Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A231768824
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2005 17:26:08 +1100 (EST)
From: "Heiko Schocher" <hs@denx.de>
To: "Paul Mackerras" <paulus@samba.org>
Date: Fri, 25 Nov 2005 07:26:01 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNOENPCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <17286.35454.210202.789136@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: [PATCH]	ppc32:	Add defconfig File for PM826 Board.
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul,

On Friday, November 25, 2005 4:53 AM Paul Mackerras wrote:
>> the following Patch (against 2.6 kernel.org tree, COMMIT_ID:
>> f093182d313edde9b1f86dbdaf40ba4da2dbd0e7) adds the defconfig
>> File for the PM826 Board from Microsys.
> 
> Your first patch added a pm82x_defconfig; why do we need both a
> pm826_defconfig and a pm82x_defconfig?

We have 4 boards PM825/PM826/PM827/PM828 -> PM82x, but on the
PM826, we don t need CONFIG_PCI, so it have its own defconfig.

Best regards
Heiko
