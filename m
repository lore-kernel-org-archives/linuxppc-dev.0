Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 652F0DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 09:49:05 +1100 (EST)
Subject: Re: Extended Addressing Mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48FFA755.5050808@genesi-usa.com>
References: <48FEEB88.6050505@kontron.com>
	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>
	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<1224713506.7654.353.camel@pasglop> <48FFA755.5050808@genesi-usa.com>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 09:48:35 +1100
Message-Id: <1224715715.7654.355.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org,
	=?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-22 at 17:21 -0500, Matt Sealey wrote:
> 
> Because we're Genesi! And we have a firmware solution that 
> kind of has to keep 32-bit pointers in the unlikely event that 
> someone actually uses the client interface (besides yaboot!).
> 
> Having I/O in the 36-bit range could cause all sorts of 
> explosions, and we're running real-mode so trapping and faking 
> I/O accesses is REALLy difficult :}

how so ? we have plethora of 32-bit firmwares including OF
implementations that can perfectly address 36 bit physical address
space. Nothing to do with having 32-bit pointers.

Cheers,
Ben.
