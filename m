Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCF41DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 00:59:36 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6BExVpR023155
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 07:59:31 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6BExN5H024146
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 09:59:24 -0500 (CDT)
Subject: Re: [PATCH] Fix mpc7448hpc2 tsi108 device_type bug
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <F63DA339-F5B1-40CB-B05E-9E40BEC3992E@kernel.crashing.org>
References: <1184135957.23157.6.camel@localhost.localdomain>
	<F63DA339-F5B1-40CB-B05E-9E40BEC3992E@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184165950.24563.11.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 11 Jul 2007 22:59:11 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-11 at 19:55, Segher Boessenkool wrote:
> > Fix mpc7448hpc2 tsi108 device_type bug.
> > Wrong device type will break the board startup.
> 
> > -             device_type = "tsi108-bridge";
> > +             device_type = "tsi-bridge";
> 
> The OS code shouldn't use "device_type" at all for this,
> but "compatible" instead.  You might want to fix that.
I can understand you. Should we separate it into two steps:
(1) Fix the bug in old style to ensure the  board work. I can see other
code in kernel tree will be affected by removing "device_type".
(2) Using compatible instead of device_type for all associated boards
and code.
> This patch is fine until you do of course.
That is fine.
Roy
