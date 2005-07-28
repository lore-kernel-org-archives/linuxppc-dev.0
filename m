Return-Path: <marny@rambler.ru>
Received: from ns.tz.ru (ns.tz.ru [194.149.234.1])
	by ozlabs.org (Postfix) with ESMTP id 35CBA67D8D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 02:18:22 +1000 (EST)
Received: from localhost (localhost.tz.ru [127.0.0.1])
	by ns.tz.ru (Postfix) with ESMTP id BEB4F173E6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 20:18:20 +0400 (MSD)
Received: from ns.tz.ru ([127.0.0.1])
	by localhost (ns.tz.ru [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 38325-03 for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 20:18:18 +0400 (MSD)
Received: from marnat.intranet.tz.ru (marnat.intranet.tz.ru [90.0.0.18])
	by ns.tz.ru (Postfix) with ESMTP id 7652816925
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 20:18:18 +0400 (MSD)
From: Igor Marnat <marny@rambler.ru>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 28 Jul 2005 20:18:17 +0400
References: <20050728125132.7B8FD352584@atlas.denx.de>
In-Reply-To: <20050728125132.7B8FD352584@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507282018.17849.marny@rambler.ru>
Subject: Re: eth1 on linux 2.4.25 from ELDK 3.1.1 becomes slowly when is
	pinged by great packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 28 July 2005 16:51, Wolfgang Denk wrote:
> You must be using old code (probably the version that came with =A0ELDK
> 3.1.1?). =A0Please =A0fetch =A0the =A0current =A0code from CVS; see commi=
t "Fix
> problems with second ethernet interface on 405EP".
> Wolfgang Denk

Wolfgang, thank you!=20
I've renewed the kernel from CVS and it works much better now.=20
By the way, the driver for PPChameleonEVB is presented in linuxppc_2_4_deve=
l=20
module only and is not presented in linux-2.4 module of CVS (there miss the=
=20
whole <linux>/drivers/net/ibm_emac directory).

Thank you again, regards,
Igor Marnat
