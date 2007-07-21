Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 53AC8DDEBE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Jul 2007 05:58:03 +1000 (EST)
Subject: ML403 / ALSA driver for AC97 Controller
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Sat, 21 Jul 2007 21:57:58 +0200
Message-Id: <1185047879.15040.34.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

some days ago I "finished" a first working version of my ALSA driver for
Xilinx' AC97 Controller Reference ip core, usually used on Xilinx' ML403
board. In fact it's a kind of byproduct of another project I am
currently working on.

Anybody interested in the driver may download it here:
http://www.esic-solutions.com/support.html

The version number 0.0.1-pre1 indicates, that it is a kind of (early)
prerelease, which might be far from a "complete" state. So, if you have
any problems with it, feel free to mail me (JOFT@gmx.de). Or, if there
are any suggestions, opinions, special experience ... etc., let me know
it.

The tar file contains a README, with all relevant info - I hope I didn't
forget something important. Just one thing: Capture support basically
works, but there are overruns after ~30s with rates > ~20kHz at least on
the board and setup I'm working on => consider this to be a know bug.
Playback support (which was the primary goal) seems to be pretty stable.

I thought it would be a good idea to publish the driver, because over
the last few months, there were - not much - but several mails on this
list on sound support for the ML403.

 Joachim
