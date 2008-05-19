Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 40219DDE1F
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 23:46:28 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4JDmPHc006030
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 09:48:26 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4JDk4R3127962
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 09:46:04 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4JDk3YT024892
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 09:46:03 -0400
Date: Mon, 19 May 2008 08:42:00 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Subject: Re: Using GPIO
Message-ID: <20080519084200.1f5f1720@zod.rchland.ibm.com>
In-Reply-To: <040b01c8b9a7$589c3b90$ad289e86@LPSC0173W>
References: <02f401c8b6a9$b1e062e0$ad289e86@LPSC0173W>
	<20080515183910.6B40A75007E@mail106-va3.bigfish.com>
	<032c01c8b72d$0555cea0$ad289e86@LPSC0173W>
	<20080516161713.9DAAD708056@mail93-wa4.bigfish.com>
	<040b01c8b9a7$589c3b90$ad289e86@LPSC0173W>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 19 May 2008 13:56:12 +0200
"Guillaume Dargaud" <dargaud@lpsc.in2p3.fr> wrote:

> Thanks for the answer,
> 
> > Dts files are not used with arch/ppc.
> My question was more general, since arch/ppc will soon (?) disapear...

"Device Tree Souce" files.  See lots of examples in
arch/powerpc/boot/dts/.  Those files are used to build the device tree
binary blob for platforms that lack OpenFirmware.

josh
