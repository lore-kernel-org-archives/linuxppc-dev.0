Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 25 Jul 2003 13:47:34 -0400
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IO, ANSI vs GCC structs
Message-ID: <20030725134734.J29161@borg.org>
References: <Pine.LNX.4.44.0307251038370.22864-100000@spider.ancor.com> <20030725161940.41FDEC602D@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030725161940.41FDEC602D@atlas.denx.de>; from wd@denx.de on Fri, Jul 25, 2003 at 06:19:35PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


How important is it to the kernel coding style that hardware be
accessed through a structure?  Is it acceptable to do:

  #define MYHW  (MY_MBAR+42)

  ...

  out_be32(MYHW, 0xco1df00d);


?


Thanks,

-kb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
