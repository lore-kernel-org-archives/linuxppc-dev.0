From: Jaap-Jan Boor <jjboor%lucent-dot-com@hzsms01.nl.lucent.com>
Message-Id: <200301201143.MAA03934@hzsms01.nl.lucent.com>
Date: Mon, 20 Jan 2003 12:43:18 +0100 (MET)
Reply-To: Jaap-Jan Boor <jjboor@denx.de>
Subject: Re: make menuconfig fails.
To: linuxppc-embedded@lists.linuxppc.org, denis@rouleau.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I am following the instructions on penguin PPC ( HYPERLINK
> "http://penguinppc.org/embedded/cross-compiling/"
> http://penguinppc.org/embedded/cross-compiling/) and I am getting an error:
> during make menuconfig
>
> checklist.c:24 dalog.h: no such file or directory
>
> I do have the file in /usr/src/linux-2.2.14/scripts/lxdialog
>
> My kernel sources for PPC are under /usr/linuxppc_2_4
>
> What am I missing?

you may have problems with your ncurses installation

Jaap-Jan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
