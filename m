To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RAMDISK Segv 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Dec 2003 16:19:03 EST."
             <3FCE5347.2070808@catapult.com>
Date: Thu, 04 Dec 2003 00:05:12 +0100
Message-Id: <20031203230517.52E5BC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FCE5347.2070808@catapult.com> you wrote:
>
> I am using the RAM disk supplied by DENX on
> an 8275 FADS board.  The kernel boots and
> the RAM disk is loaded.  busybox starts
> and then I get segv's.  Any idea as to
> what is happening ?

Which sort of boot loader are you suing, and what is your memory  map
(for  example,  at  which  physical addresses are the IMMR, BCSR etc.
mapped)?

My speculation is that your memory map is broken.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Plan to throw one away.  You will anyway."
                              - Fred Brooks, "The Mythical Man Month"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
