To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: openssl 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Mar 2003 18:11:54 +0200."
             <75DF04AC5ED4D511A9810090273CB41661519B@ROKONET-E>
Date: Wed, 12 Mar 2003 20:42:09 +0100
Message-Id: <20030312194214.10A46C58BB@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <75DF04AC5ED4D511A9810090273CB41661519B@ROKONET-E> you wrote:
>
> We are working with ELDK 2.0.2, target - TQM860L
...
> We don't have the /dev/random and /dev/urandom. How do we create them -
> mknod?

it's not that trrivial. Normally, many sources  of  "ramdomness"  are
used to generate input for the random device, like key presses on the
keyboard,  mouse movements, etc. Most of this is simply not available
in an embedded system. You will have to tweak this a bit...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I have a theory that it's impossible to prove anything, but  I  can't
prove it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
