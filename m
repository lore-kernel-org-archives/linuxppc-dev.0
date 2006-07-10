Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B57867B5F
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 23:21:25 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6ADLLvO026537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 09:21:21 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6ADLL5w246516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 09:21:21 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6ADLKtU011816
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jul 2006 09:21:20 -0400
Subject: Re: Linux v2.6.18-rc1
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152441242.4128.33.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
	<pan.2006.07.07.15.41.35.528827@us.ibm.com>
	<1152441242.4128.33.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 08:21:12 -0500
Message-Id: <1152537672.28828.4.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-09-07 at 20:34 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-07-07 at 10:41 -0500, Steve Fox wrote:
> > We've got a ppc64 machine that won't boot with this due to an IDE error.
> 
> What machine precisely ?

I see a slightly more verbose version on a JS20 blade. 

hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt



> 
> > [snip]
> > Freeing unused kernel memory: 256k freed
> >  running (1:2) /init autobench_args: ABAT:1152213829
> > 
> > creating device nodes .hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > hda: lost interrupt
> > 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
