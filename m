To: jbates@paradise.co.uk
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK on MPC8260ADS board, Machine check in kernel 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 Dec 2003 12:50:47 GMT."
             <OJEPIMKHOKJAJIDJLJBNMEIMCAAA.jbates@paradise.co.uk>
Date: Thu, 11 Dec 2003 18:30:40 +0100
Message-Id: <20031211173045.41413C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear James,

in message <OJEPIMKHOKJAJIDJLJBNMEIMCAAA.jbates@paradise.co.uk> you wrote:
>
> I am trying to get linux running on my standard MPC8260ADS board but I have
> hit a dead end.

Reading the FAQ's and mailing list archives is recommended.

> I am getting a "Machine check in kernel mode." error about the time that
> ramdisks are setup.

Try updating U-Boot to a recent  version,  or  at  least  change  the
#define  for CFG_BCSR into 0xF4500000 (instead of the silly 04500000)
in "include/configs/MPC8260ADS.h" (also change  CFG_LSDRAM_BASE  into
0xFD000000 while you are at it).

> I am using the linuxppc_2_4_devel eldk which I checked out this week and
> u-boot 0.4.0. I have added the boot output at the end of this message for
> those that are interested. I have also attempted to make some sense of the
> backtrace from the System.map

It would have been nice if  you  hadd  added  the  results  of  these
attempts, too.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A metaphor is like a simile.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
