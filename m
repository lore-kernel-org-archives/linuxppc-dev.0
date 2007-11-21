Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B260DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 00:23:54 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lALDNo1P030989
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:23:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lALDNnAl128290
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:23:49 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lALDNnFB015668
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:23:49 -0700
Date: Wed, 21 Nov 2007 07:23:48 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH 0/14] powerpc: 4xx PCI and PCI-X support
Message-ID: <20071121072348.7fff79a9@weaponx>
In-Reply-To: <1195625777.579001.269266058699.qpush@grosgo>
References: <1195625777.579001.269266058699.qpush@grosgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 21 Nov 2007 17:16:17 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Here's a set of patches that bring PCI and PCI-X support for
> 4xx (PCIe still missing) in arch/powerpc.
> 
> This is for review before I ask paulus to pull that into his
> for 2.6.25 tree. Some of the patches still need a bit more
> testing vs. regressions on other platforms such as the
> 64 bits resource fixup one.

I'm starting my 2.6.25 branch today.  I'll probably throw these in
there after I've tested a bit, since I need them to make further
progress with 4xx anyway.

josh
