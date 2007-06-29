Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19926DDFCE
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 00:50:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5TEotSX031540
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 10:50:55 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5TEotqd237358
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 08:50:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5TEos3h006153
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 08:50:55 -0600
Subject: Re: [PATCH] dtc: Add install makefile target
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070629143414.GA13053@aepfle.de>
References: <1183125374.30145.14.camel@weaponx.rchland.ibm.com>
	<20070629143414.GA13053@aepfle.de>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 09:50:53 -0500
Message-Id: <1183128653.30145.26.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-29 at 16:34 +0200, Olaf Hering wrote:
> On Fri, Jun 29, Josh Boyer wrote:
> 
> > +DESTDIR = /
> > +BINDIR = usr/bin
> 
> +DESTDIR=
> +BINDIR=/usr/bin
> 
> Just like every other package out there.

Urgh.  I thought I had fixed that already.  Will resubmit.

josh
