Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91EA1679F2
	for <linuxppc-dev@ozlabs.org>; Sat,  7 May 2005 10:06:13 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddy Petrisor <eddy.petrisor@gmail.com>
In-Reply-To: <427BE8B0.5030802@gmail.com>
References: <1115072133.6031.33.camel@gaston>
	<20050503222200.GA29940@cse.unsw.EDU.AU>
	<1115163690.7568.45.camel@gaston> <427BE8B0.5030802@gmail.com>
Content-Type: text/plain
Date: Sat, 07 May 2005 10:06:00 +1000
Message-Id: <1115424360.23610.21.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	DebianPPC <debian-powerpc@lists.debian.org>
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-05-07 at 00:59 +0300, Eddy Petrisor wrote:
> Benjamin Herrenschmidt wrote:
> > 
> > I don't know this problem, what happens precisely and what model of
> > radeon chip do you have ?
> > 
> I am just interfering as you talked about radeon models; is there any 
> good news regarding the >9600 chipsets?
> I know there was a project (R300 iirc) that wanted to make a driver, but 
> progress was slow or non-existant last time I heard about it.

There is a fully working 2D driver and there is an in-progress 3D driver
based on some sort of reverse engineering. It works weel enough for some
things like tuxracer, pinball or bzflag :) You probably need to get all
sort of up to date CVS things to get it to work though (X.org, DRI and
Mesa)

Ben.
