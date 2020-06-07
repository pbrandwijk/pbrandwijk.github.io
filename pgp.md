---
layout: page
title: "Email me with PGP"
---
# {{ page.title }}

I would like to invite you to use encryption to email me. For those who are familiar with PGP, you can get my public key from [https://keyserver2.pgp.com/](https://keyserver2.pgp.com/) or download it directly from [here]({{ "assets/pieter-brandwijk.asc" | prepend: site.baseurl }}).

My full key fingerprint is: {{ site.pgp_fingerprint }}.

## What is PGP?
PGP, or more precise OpenPGP, is a standard for encryption. It is used in particular for sending encrypted email. It is supported by many email clients, often via a plug-in. Thunderbird for example supports PGP via the Enigmail plug-in.

PGP uses what is called *public-key cryptography*. This means that there is a file with a long code that you share publicly. People who want to encrypt something for you use the code in this file. Now the trick is that you can only decrypt the file if you have the private key, a file with the companion code of your public key. As long as you are the only one with access to your private key, you are the only one who can decrypt messages that were encrypted using your public key.

## Why should I use encryption in email?
Sending an unencrypted email is very similar to sending a paper letter to someone without using an envelope. Anyone with access to it can read it and store a copy. In the case of a paper letter this could be someone at the post office, or a house mate who picks up the mail. With email, this can be literally anyone. Think about this for a moment. Every email that you have sent in your life may currently be in possession of someone you did not intend it for. Every email you ever sent!

Of course, for many emails you ever sent you don't care, in the same way you may send a post card from your holiday to your grandmother and not care who else reads it along the way. But I'm sure there are some emails you do care about. Emails maybe which you write to a trusted friend about your personal struggles or deeper emotions. Maybe an email in which you shared a password or credit card number, because it was the most practical way to share that information. If you do not encrypt your email, there is just no telling where you personal information may have ended up.

So even though not everything you send is top secret, at times you will send emails containing private information. For this, there is encryption. And in order for encryption to work well, it makes sense to use it by default. This is why I would like to invite you to use encryption when emailing me.

## How can I send you an encrypted email?
First you need to install PGP software on your computer. This allows you to generate your public and private key pair and to encrypt files for others using their public key. It is helpful to also install a plug-in for your email client, so that you don't have to do the tedious steps of encryption every time you send a mail, but rather let the plug-in do that work for you.

Next you need to add the public keys of the people you are going to email with. They can either give them to you in a file, like I do [here]({{ "assets/pieter-brandwijk.asc" | prepend: site.baseurl }}). Or, if they have uploaded their key to a key server, you can get them there. You can find my key at [https://pgp.surfnet.nl/](https://pgp.surfnet.nl/) by inputing my email address in the search box.

## Links
- [Why You Should Encrypt Your Email][lifewire]
- [Your E Mail Can Be Intercepted or Hacked][nairaland]

[lifewire]: https://www.lifewire.com/you-should-encrypt-your-email-2486679
[nairaland]: http://www.nairaland.com/170659/e-mail-intercepted-hack-check
