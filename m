To: Bryan Rittmeyer <bryan@ixiacom.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Reply-To: ppcboot-users@lists.sourceforge.net
Subject: Re: bootloader for deeply embedded 405CR 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Apr 2001 13:44:26 PDT."
             <3AD370AA.93F59622@ixiacom.com>
Date: Tue, 10 Apr 2001 23:16:44 +0200
Message-Id: <20010410211649.9C41328417@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


*** Please send PPCBoot related messages to the PPCBoot mailing list ***




In message <3AD370AA.93F59622@ixiacom.com> you wrote:
>
> > For the Walnut it should be a simple thing to do:
> >         make WALNUT405_config
> >         make
>
> I have built a CVS ppcboot as you suggest, however
> it appears to expect being burned into flash
> memory.

Right. That's what most of the people do.

> What I would like to do is GDB-load an ELF ppcboot
> into the Walnut's 32MB SDRAM mapped at address 0,
> then execute it in place. Then I want to GDB load a
> kernel at another higher address, and use ppcboot
> to boot it. Is this already possible or will I have
> to modify Makefiles, linker scripts, and possibly
> code?

You have to modify the link address at least; but most  probably  you
have  to  modify  other  code  as  well - for instance to prevent the
exception handlers to be installed, etc.

Why don't you do what everybody does, and write the image to flash?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Here's a fish hangs in the net like a poor man's right in  the  law.
'Twill hardly come out."     - Shakespeare, Pericles, Act II, Scene 1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
