Return-Path: <ilopez@albatros-sl.es>
Received: from sina-sl.es (unknown [82.198.120.42])
	by ozlabs.org (Postfix) with ESMTP id D9B932BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 04:08:13 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 18 Nov 2004 17:55:49 +0100
Message-ID: <42A622EB18325843894BB8E1040E3DF5022830@sinaexchf>
From: =?iso-8859-1?Q?I=F1igo_Lopez_Barranco?= <ilopez@albatros-sl.es>
To: <linuxppc-embedded@ozlabs.org>
Subject: Ethernet on 5200 is using DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi. I'm using linuxppc_2_4_devel from Denx CVS on a Lite5200 board.
When doing "put" of a large file to a ftp server, ftp eats all the CPU =
available (90%+). I suspect it's not using DMA for the ethernet. Is this =
right?
Thanks in advance.

I=F1igo
