Date: Thu, 27 Jul 2000 14:20:29 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: tom_gall@vnet.ibm.com
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RS/6000 Model 170 Boots Linux
In-Reply-To: <397F2344.CCCE7FD0@vnet.ibm.com>
Message-ID: <Pine.LNX.4.10.10007271418210.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 Jul 2000 tom_gall@vnet.ibm.com wrote:
>   Here is the boot log of an RS/6000 Model 170 which for the first time booted
> Linux this past Friday.
>
>   If I recall correctly it's a 375 Mhz Power 3 box. It's kinda weird as you'll
> notice below the OpenPIC line indicates there are 8 processors here... well
> there isn't, it's just a single processor box. Patches to be posted shortly.

> OpenPIC Version 1.2 (8 CPUs and 1 IRQ sources) at ffc00000

It doesn't mean that the box has 8 CPUs, but that the OpenPIC can handle 8
CPUs. So the weird thing is that the OpenPIC can handle only one interrupt
source. Would you really want to build an OpenPIC for only one interrupt
source?

FYI, on my LongTrail it says `2 CPUs and 20 IRQ sources', which is correct for
the OpenPIC in the Apple Hydra.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/


Received: from localhost (IDENT:root@localhost [127.0.0.1])
	by denx.muc.de (8.9.3/8.9.3) with ESMTP id RAA17556
	for <wd@localhost>; Thu, 27 Jul 2000 17:57:15 +0200
Delivered-To: denx.de-default@denx.de
Received: from popmail.space.net
	by localhost with POP3 (fetchmail-5.0.0)
	for wd@localhost (single-drop); Thu, 27 Jul 2000 17:57:15 +0200 (MEST)
Received: (qmail 8984 invoked by uid 512); 27 Jul 2000 13:40:06 -0000
Delivered-To: i-dial.de-wolfgang.denk@i-dial.de
Received: (qmail 8946 invoked by uid 512); 27 Jul 2000 13:40:02 -0000
Delivered-To: denx.de-wd@denx.de
Received: (qmail 8931 invoked from network); 27 Jul 2000 13:40:02 -0000
Received: from mail.space.net (195.30.0.8)
  by popmail.space.net with SMTP; 27 Jul 2000 13:40:02 -0000
Received: (qmail 1821 invoked from network); 27 Jul 2000 13:40:00 -0000
Received: from lists.linuxppc.org (169.207.161.3)
  by mail.space.net with SMTP; 27 Jul 2000 13:40:00 -0000
Received: from localhost (majordomo@localhost)
	by lists.linuxppc.org (8.9.1a/8.9.1) with ESMTP id IAA24642;
	Thu, 27 Jul 2000 08:35:06 -0500
Received: by lists.linuxppc.org (TLB v0.11a (1.26 tibbs 1998/09/22 04:41:41)); Thu, 27 Jul 2000 08:34:41 -0500 (CDT)
From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Date: Thu, 27 Jul 2000 15:44:10 -0500
Message-ID: <yam8243.505.140601712@mail.lf-online.de>
In-Reply-To: <Pine.LNX.4.10.10007271409430.434-100000@cassiopeia.home>
X-Mailer: YAM 1.3.4 [040] - Amiga Mailer by Marcel Beck
Organization: Hyperion
Subject: Re: sound again [was: Re: xf4 bug report]
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
Precedence: bulk
X-Mailing-List: <linuxppc-dev@lists.linuxppc.org>
X-Loop: linuxppc-dev@lists.linuxppc.org
X-Filter: mailagent [version 3.0 PL65] for wd@denx.de


Am 27-Jul-00 schrieb Geert Uytterhoeven:

Hi!

>That was how it was before Commodore and Atari died. We've been united since
>Linux/m68k exists :-)

Hmmm... most Amiga users I know don't care for 68k anymore :) But I suggest
we drop that matter now... :) Probably not really interesting for most people
on the list :)))

Steffen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
