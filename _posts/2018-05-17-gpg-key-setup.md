---
layout: post
title:  "GPG key setup"
date:   2018-05-17 15:45:00 +0200
categories: encryption gpg
---
*In this post I describe my learning process of setting up my GPG keychain. I separate the master key from the signing and encryption keys.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS, which comes with `gpg` 2.2.4 and `libgcrypt` 1.8.1.

## Set up GnuPG to display the long key IDs and fingerprints by default.
To do this add the following to the file `~/.gnupg/gpg.conf`
```
# Change default key ID display, see https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration-Options.html
keyid-format long
with-fingerprint
```

## Generate a new keypair
With expiry date of less than 2 years and 4096 bit size. Don't give a [comment on the UID][uid-comments-harmful]. Generate only a signing key.
```console
$ gpg --full-generate-key
```

Afterwards you can look up the key id with:
```console
$ gpg -k   # List public keys
$ gpg -K   # List secret keys
```

Also, be sure to make a safe copy or print out of the revocation certificate. Without it, if you ever lose your key or the key gets compromised, you will not be able to revoke it. `gpg` prints out the location of the revocation certificate after generation the key pair. It will be in the folder `~/.gnupg/openpgp-revocs.d/`.

## Generate a signing and an encryption subkey
Choose RSA sign only and 4096 bits. Then add another key with RSA encrypt only.

```console
$ gpg --edit-key <key-id>

gpg> addkey
```

## Transport the master key to a safe external location
Make an export file of both your public and private keys like so:
```console
$ gpg --export-secret-keys --armor <your email address> > private-key.asc
$ gpg --export --armor <your email address> > public-key.asc
```
Store these keys in a safe location, like on an encrypted USB stick (see [this post][usb-encryption]) or print them out on paper. Then remove them from your system.

Make an export of your secret subkeys (so not including the master secret key) like so:
```console
$ gpg --export-secret-subkeys <your email address> > subkeys.gpg
```

Now remove all your secret keys and then re-import the secret subkeys:
```console
$ gpg --delete-secret-key <your email address>
$ gpg --import subkeys.gpg
```

If you now check your secret keys with `gpg -K` you will see your master secret key presented as `sec#`. This means that the actual secret key is indeed no longer present on your system.

## Resources
- [Establish your online identity using GnuPG][saminiir]
- [Create GnuPG key with sub-keys to sign, encrypt, authenticate][tinned]
- [Creating the perfect GPG keypair][alexcabal]
- [OpenPGP best practices][riseup]
- [How can I encrypt with my previous GPG subkey after creating a new one?][stackexchange]
- [Debian Wiki: Subkeys][subkeys]
- [Passphrases you can memorize][intercept]
- [Using various subkeys][gnupg]
- [OpenPGP subkeys][connexer]
- [OpenPGP User ID Comments considered harmful][uid-comments-harmful]
- [USB Encryption][usb-encryption]

[alexcabal]: https://alexcabal.com/creating-the-perfect-gpg-keypair/
[saminiir]: http://www.saminiir.com/establish-cryptographic-identity-using-gnupg/
[uid-comments-harmful]: https://debian-administration.org/users/dkg/weblog/97
[tinned]: https://blog.tinned-software.net/create-gnupg-key-with-sub-keys-to-sign-encrypt-authenticate/
[riseup]: https://riseup.net/en/security/message-security/openpgp/best-practices
[stackexchange]: https://unix.stackexchange.com/questions/234273/how-can-i-encrypt-with-my-previous-gpg-subkey-after-creating-a-new-one
[subkeys]: https://wiki.debian.org/Subkeys
[intercept]: https://theintercept.com/2015/03/26/passphrases-can-memorize-attackers-cant-guess/
[gnupg]: https://lists.gnupg.org/pipermail/gnupg-users/2002-August/014780.html
[connexer]: http://www.connexer.com/articles/openpgp-subkeys
[usb-encryption]: {% post_url 2018-05-17-usb-drive-encryption %}
