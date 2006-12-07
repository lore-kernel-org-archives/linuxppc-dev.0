Return-Path: <hollis@penguinppc.org>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A50667C66
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 07:36:05 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB7KZepO011467
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 15:35:40 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB7KZewV181862
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 15:35:40 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB7KZefO027680
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 15:35:40 -0500
Subject: Re: libfdt - flat tree manipulation library
From: Hollis Blanchard <hollis@penguinppc.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20061127055905.GA6428@localhost.localdomain>
References: <20061127055905.GA6428@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 14:35:34 -0600
Message-Id: <1165523734.8900.10.camel@basalt>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-27 at 16:59 +1100, David Gibson wrote:
> 
>         - License is GPL for now.  I'm looking into the red tape to
> get it released as BSD or other non-restrictive license, so that it
> can be used in closed bootloaders.

A GPL license means it cannot be used in Xen today (that part of the
code is BSD-licensed), nor could it be used in developing non-GPL
firmwares.

-Hollis
