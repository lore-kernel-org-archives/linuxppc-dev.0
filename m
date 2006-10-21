Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B42FB67BAC
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Oct 2006 09:25:23 +1000 (EST)
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6B8FAF75-44DF-4638-BD7D-AF6BB063F339@kernel.crashing.org>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
	<4538DC0B.7060402@bplan-gmbh.de>
	<6B8FAF75-44DF-4638-BD7D-AF6BB063F339@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 22 Oct 2006 09:25:13 +1000
Message-Id: <1161473113.10524.264.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I was just thinking, as this code is alraedy in some Linux tree, we  
> > could still use it there, and plan to replace it by a much better  
> > one (keeping the API compatible) later on.
> 
> Is this in the kernel tree already, I am not coming across it.

Probably only in the WD tree and not even attempted to be merged like
most of the gunk in there...

Ben
