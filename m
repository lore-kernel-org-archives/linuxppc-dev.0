To: Sylvain Munaut <tnt@246tnt.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on MPC5200 - LITE5200EVAL 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 12 Feb 2004 00:58:28 +0100."
             <402AC1A4.7070304@246tNt.com>
Date: Sat, 14 Feb 2004 01:16:23 +0100
Message-Id: <20040214001628.637C3C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <402AC1A4.7070304@246tNt.com> you wrote:
>
> The "new" output is included at the end , quite similar.
>
> One other weird things is that I was forced to setenv bootargs, then
> saveenv it, then reset to try to boot. If i just set the bootargs before
> the bootm, it decompressed the two images, but the kernel was not
> (apparently) starting ...

Did you make any progress? If  not:  are  you  absolutely  sure  your
hardware is OK?


Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There has been an alarming increase in the number of things you  know
nothing about.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
