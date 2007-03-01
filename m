Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41EBFDDEBF
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 12:55:34 +1100 (EST)
In-Reply-To: <20070228233801.GC3048@localhost.localdomain>
References: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
	<20070228005615.GE11775@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302AA071F@az33exm25.fsl.freescale.net>
	<20070228233801.GC3048@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5984965b297a0e8f6ea9485f2356e226@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] powerpc: Document new property called interrupt-parents
Date: Thu, 1 Mar 2007 02:55:27 +0100
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Do the version and last_comp_version in the blob header
>> help here?
>
> Unfortunately not.  Those fields version the the serialization format
> of the device tree, not the content of the device tree.

I'm glad you agree :-)


Segher
