Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw5.extranet.tce.com (dmzraw5.extranet.tce.com
	[157.254.234.142]) by ozlabs.org (Postfix) with ESMTP id ADAB468387
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Oct 2005 21:21:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 7 Oct 2005 13:21:05 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0E0D@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Wojciech Kromer" <wojciech.kromer@dgt.com.pl>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: mpc8248 and FCC ethernet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wojciech Kromer wrote:
[..]
>But inside kernel all RX frames are filled with 0xff data,
>also send frames I can see on the other side, are full of 0xff.
>Clocks and other FCC aware registers seems to be correct.
>The same version on linux (2_4_devel from denx.de) works fine
>on another mpc8260 board.

Most likely, you're using a wrong DPRAM range.
This reminds me this problem "All-ones problem with FCC1 on MPC8541"
=20
http://ozlabs.org/pipermail/linuxppc-embedded/2004-November/016050.html

so double check your manual. The MPC8555E manual is still wrong in
this regard, and no errata has been issued yet.

--=20
Stephane
