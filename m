Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED2FD67A7F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Feb 2005 02:10:41 +1100 (EST)
Received: from ng (80-218-254-31.dclient.hispeed.ch [80.218.254.31])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id
	j1RFAZ99026876
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Sun, 27 Feb 2005 16:10:36 +0100
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-embedded@ozlabs.org
Date: Sun, 27 Feb 2005 16:10:30 +0100
References: <200502262328.24165.niklaus.giger@member.fsf.org>
In-Reply-To: <200502262328.24165.niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200502271610.30615.niklaus.giger@member.fsf.org>
Subject: Re: Problems porting to a custom PPC405GPr board using a vanilla
	2.6.10 kernel
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Samstag, 26. Februar 2005 23.28 schrieb Niklaus Giger:
> Hi
>
> I would like to port Linux to a custom PPC405GPr board. Its hardware runs
> vxWorks fine for more than a year.
>
I made some more progress. After adding 3 lines for MMU support with the BDI
I can debug the startup up to kernel_start using BDI.=20

Afterwards my console changes the baudrate for still unknown reasons.

Analysing the __log_buf I get the following output
(gdb) x/s &__log_buf
0xc01accfc <ratelimit_lock.9>:   "<4>Linux version 2.6.10=20
(niklaus@ng.ngiger.dyndns.org) (gcc-Version 3.3.5 (Debian 1:3.3.5-8)) #15 S=
un=20
=46eb 27 14:44:27 CET 2005\n<7>On node 0 totalpages: 8240\n<7>  DMA zone: 8=
240=20
pages, LIFO batch:2\n<7>"...
(gdb) x
0xc01acdc4 <ratelimit_lock.9+200>:       "  Normal zone: 0 pages, LIFO=20
batch:1\n<7>  HighMem zone: 0 pages, LIFO batch:1\n<4>Built 1=20
zonelists\n<4>Kernel command line: ip=3D172.25.1.6\n<4>PID hash table entri=
es:=20
256 (order:8, 4096 bytes)\n"
(gdb) x
0xc01ace84 <ratelimit_lock.9+392>:       ""

>My board has no RTC. Is this a problem?=20
>
>Should I start with another kernel? Can anybody point me to a known good=20
>kernel version for a specific PPC405 board?

Any hint would be greatly appreciated.

Best regards

=2D-=20
Niklaus Giger
Wieshoschet 6
CH-8753 Mollis
Tel. ++41 55 612 20 54 (privat)
Tel. ++41 55 618 64 68 (Gesch=E4ft)
