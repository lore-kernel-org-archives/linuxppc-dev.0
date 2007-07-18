Return-Path: <linas@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B78FDDF7C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 04:47:47 +1000 (EST)
Received: from e2.ny.us.ibm.com ([192.168.1.102])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6IILQgs027373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:21:26 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6IIIDjA022051
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:18:13 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6IIIDgW469900
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:18:13 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6IIIDm8031676
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 14:18:13 -0400
Date: Wed, 18 Jul 2007 13:18:07 -0500
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH v2] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Message-ID: <20070718181807.GH5771@austin.ibm.com>
References: <20070709214853.GA29912@ld0162-tx32.am.freescale.net>
	<1184705168.24473.32.camel@ld0161-tx32>
	<469D3F60.8000401@freescale.com> <E1IAvmA-00062M-F4@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1IAvmA-00062M-F4@jdl.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 05:44:14PM -0500, Jon Loeliger wrote:
> <Top Posting Carnac>
> 
> A:  They haven't been posted yet.
> 
> Q:  How do we know Segher has new patches?
> 
> </Top Posting Carnac>

rotfl -- rolling on the floor loeliger !
