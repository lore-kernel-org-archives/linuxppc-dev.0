Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1D10DDEB8
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 07:02:03 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8OL1vPj007278
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 17:01:57 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8OL1sVN495428
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 15:01:56 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8OL1onJ011275
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 15:01:51 -0600
Date: Mon, 24 Sep 2007 16:01:49 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Sequoia kernel crash workaround.
Message-ID: <20070924160149.1809de00@weaponx.rchland.ibm.com>
In-Reply-To: <1190667350.6886.59.camel@localhost.localdomain>
References: <46F16CC9.3010003@ru.mvista.com> <200709192119.48259.sr@denx.de>
	<20070919193024.GA28163@lixom.net>
	<20070919150818.3fecc1bc@weaponx.rchland.ibm.com>
	<46F2A640.1000802@ru.mvista.com> <20070920172506.GA16354@lixom.net>
	<20070920122919.32dd8061@weaponx.rchland.ibm.com>
	<1190535664.3723.16.camel@localhost.localdomain>
	<46F79305.9050300@ru.mvista.com>
	<1190667350.6886.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	Josh Boyer <jwboyer@gmail.com>, Stefan Roese <sr@denx.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Sep 2007 06:55:50 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Mon, 2007-09-24 at 14:35 +0400, Valentine Barshak wrote:
> > 
> >  From what I've seen, setup_cpu is never called for BOOKE.
> > Currently It's called from cputable.c for PPC64 and from head_32.S for
> > 6xx.
> > Thanks,
> 
> Right. We need to fix/converge some of these but it's not totally
> trivial.

Valentine has patches for adding this for BookE on the list.

josh
