To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boot Loader 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Dec 2003 06:59:47 EST."
             <3FE6DCB3.109@catapult.com>
Date: Mon, 22 Dec 2003 14:08:53 +0100
Message-Id: <20031222130859.09C20C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Kevin,

in message <3FE6DCB3.109@catapult.com> you wrote:
>
> For my end target I have to boot across a shared memory
> interface by placing the executable into RAM.  This is
> part of a multi processor system where the Linux board
> is a cPCI slave.  The Linux board will not have a flash
> or a network connection.  I is held in reset by the master
> until the s/w is loaded and then released.  This is an 8275

This has been done before. See for example the  "PN62"  configuration
in U-Boot.

> Any suggestions on how to do this ?

Use U-Boot...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It all seemed, he thought, to be rather a lot of  trouble  to  go  to
just sharpen a razor blade.  - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
