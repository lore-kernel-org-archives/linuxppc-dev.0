To: "SangTae Ha" <stha@postech.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RPXclassic PPCBOOT on RAM 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Jun 2001 14:44:43 +0900."
             <010601c0fd39$ef0cca90$3877b5d3@dolbae>
Date: Mon, 25 Jun 2001 10:48:42 +0200
Message-Id: <20010625084847.744FD10072@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <010601c0fd39$ef0cca90$3877b5d3@dolbae> you wrote:
>
> I am trying to have the PPCBOOT work on RPXclassic board. I've

I don't see any Linux content in this message, so it's off  topic  in
this mailing list.

Chances to receive help for PPCBoot porting issues are much better in
the PPCBoot User's mailing list.

> already port the 8xxROM this board already but I've failed with
> PPCBOOT. All configuration parameters are same with 8xxROM and my
> BDI2000 didn't get the flash information of RPXClassic (FLASH TYPE,
> CHIPSIZE, BUSWIDTH), therefore I really want to test the PPCBOOT on

When you don't have such basic hardware information you better forget
about low-level work like porting PPCBoot.

> RAM space first to debug. In order to make srec file run on RAM

This is not a good idea.

Executing code from the boot device (flash memory)  is  the  simplest
thing  you  can  do.  Running  from (SD)RAM is MUCH more complicated,
since it needs a LOT of  initialization  which  must  be  correct  or
you'll just see random problems.

It is NOT a good idea to try complicated things as long as you  don't
have the muchg simpler things running first.

> there woule be many efficient debugging techniques. I am currently
> using BDI2000, as I mentioned above, but I couldn't get the flash
> work. How can I debug the PPCBOOT efficiently in my current stage?

Why not? You know the flash type. There are two ways to attach it  to
the  bus  (as  8  or as 16 bit devices), and there are 4 possibel bus
widths (8, 16, or 32 bit). Even without any further information it is
just a couple of minutes to try out these 8 possible combinations.

When you cannot get flash working, I guarantee  you  will  fail  with
SDRAM, too.

> Any comments would be appreciated.

Try simple things first.

And better post such questions to the ppcboot mailing list.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: kernel trap (ignored)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
