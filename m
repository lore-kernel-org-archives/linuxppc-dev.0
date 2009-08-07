Return-Path: <ljaenicke@innominate.com>
Received: from home.innominate.com (home.innominate.com [77.245.32.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE3D0B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 21:02:33 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by home.innominate.com (Postfix) with ESMTP id F1966232BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 13:02:29 +0200 (CEST)
Received: from home.innominate.com ([127.0.0.1])
	by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id OeOPEr3t+qhE for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 13:02:29 +0200 (CEST)
Received: from lutz.bln.innominate.local (lutz.bln.innominate.local
	[10.1.0.160])
	by home.innominate.com (Postfix) with ESMTP id C6E9723143
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 13:02:29 +0200 (CEST)
Date: Fri, 7 Aug 2009 13:02:29 +0200
From: Lutz Jaenicke <ljaenicke@innominate.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC8313 performance evaluation
Message-ID: <20090807110229.GA20709@lutz.bln.innominate.local>
References: <20090806180035.GA19088@lutz.bln.innominate.local>
	<D7CCA83BB0796C49BC0BB53B6AB1208956D03F@zch01exm21.fsl.freescale.net>
	<20090807105654.GA20678@lutz.bln.innominate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090807105654.GA20678@lutz.bln.innominate.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 07, 2009 at 12:56:54PM +0200, Lutz Jaenicke wrote:
> On Fri, Aug 07, 2009 at 04:08:50PM +0800, Liu Dave-R63238 wrote:
> > 
> > > Some discussion with the the freescale rep. lead to the CSB frequency
> > > of the 8313 (166MHz) being significantly lower than that of the 8343.
> > > Is the CSB the critical point here?
> > 
> > I believe the CSB is critical point here. They are right.
> 
> This indeed indicates that the CSB is the limiting factor.
> Until a few days ago I have not even been aware of the CSB being a
> performance critical component. All of the nice powerpoints explaining
> the processors and used for comparing different families shown by the
> Freescale Rep include the core frequencies and the DRAM interface
> and frequency but do not even mention the CSB...

Having this said, is there any good white paper to be read about it?
For firewall usage there are different influence factors:
* Ethernet interfaces (DMA to/from DRAM via CSB!?)
* CPU processing for the firewall rules (code/data to/from DRAM closely
  related to cache size or misses)
Hence I would like to understand better the impact of the different
components.
(If only available under NDA I can also contact my Freescale Rep but
having public source always makes things easier.)

Best regards,
	Lutz
-- 
Dr.-Ing. Lutz Jänicke
CTO
Innominate Security Technologies AG  /protecting industrial networks/
tel: +49.30.921028-200
fax: +49.30.921028-020
Rudower Chaussee 13
D-12489 Berlin, Germany
www.innominate.com

Register Court: AG Charlottenburg, HR B 81603
Management Board: Dirk Seewald
Chairman of the Supervisory Board: Volker Bibelhausen
