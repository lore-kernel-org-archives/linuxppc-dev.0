Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 6A14B67B32
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 18:56:36 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id A28C1CC165
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 10:26:09 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 5EAC0CC025
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 10:26:09 +0200 (CEST)
Received: from kah.ulm.sysgo.com (kah.sysgo.com [172.40.1.2])
	by donald.sysgo.com (Postfix) with ESMTP id 2156E26857B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Aug 2006 10:26:06 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id KAA10102
	for <linuxppc-embedded@ozlabs.org>; Mon, 28 Aug 2006 10:52:13 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Cache coherency question
Date: Mon, 28 Aug 2006 10:26:00 +0200
References: <4879B0C6C249214CBE7AB04453F84E4D0FC602@zch01exm20.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC602@zch01exm20.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608281026.00619.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 28 August 2006 09:08, Li Yang-r58472 wrote:
> 
> > -----Original Message-----
> > From: Liu Dave-r63238
> > Sent: Monday, August 28, 2006 3:00 PM
> > To: Li Yang-r58472; 'Martin, Tim'; 'ppc'
> > Subject: RE: Cache coherency question
> > 
> > <snip>
> > > Looking from source code, there is such problem for MV64360.
> > > It's likely that MV54360 has the same problem.
> > 
> > What is the MV54360?
> 
> From document at
> http://www.motorola.com/mot/doc/5/5503_MotDoc.pdf#search=%22MV54360%22
> The board uses MV54360.
> 
> I don't know if it is a typo or new variant though.

It's definitely a typo. In the block diagramm you'll see Discovery II
as system bridge and this one is the Marvel MV64360 (at least on the MVME6100).

-Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 
