Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id B719E679E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Mar 2006 03:57:37 +1100 (EST)
Received: from White64 (p54B4AFD9.dip0.t-ipconnect.de [84.180.175.217])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id k2FGw6P25176
	for <linuxppc-embedded@ozlabs.org>; Wed, 15 Mar 2006 17:58:21 +0100
Date: Wed, 15 Mar 2006 17:58:08 +0100
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: buildroot  uClibc busybox and associated tool versions
Message-ID: <20060315175808.2bd1ae70@White64>
In-Reply-To: <loom.20060314T023032-451@post.gmane.org>
References: <loom.20060314T023032-451@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

i'm using gcc 3.4.6
uclibc Release 0.9.28
busybox daily Snapshot.



With uclibc Snapshot i get an toolchain, but on the Target: 
busybox init segfaults during init, at different points.
(but the snapshots uclibc build with gcc 4.1 and 4.2 :)

With gcc 4.x i get Compiler Errors, because of the weak aliases in
uclibc.

I test this last at 7.3 

Would be nice to get Infos, which Combinations works... 

Gcc 4.x would be nice to test.

Bye
