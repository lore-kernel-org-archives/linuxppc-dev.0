Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E29CDDE2C
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 10:18:29 +1000 (EST)
Subject: Re: pte_offset_map for ppc assumes HIGHPTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave McCracken <dave.mccracken@oracle.com>
In-Reply-To: <200707251830.21944.dave.mccracken@oracle.com>
References: <acbcf3840707251516w301f834cj5f6a81a494d359ed@mail.gmail.com>
	<jewswodqcn.fsf@sykes.suse.de>
	<1185405765.5439.371.camel@localhost.localdomain>
	<200707251830.21944.dave.mccracken@oracle.com>
Content-Type: text/plain
Date: Thu, 26 Jul 2007 10:18:13 +1000
Message-Id: <1185409094.5495.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-07-25 at 18:30 -0500, Dave McCracken wrote:
> On Wednesday 25 July 2007, Benjamin Herrenschmidt wrote:
> > Depends... if you have CONFIG_HIGHMEM and not CONFIG_HIGHPTE, you are
> > wasting time going through kmap_atomic unnecessarily no ? it will probably
> > not do anything because the PTE page is in lowmem but still...
> 
> Probably not much time.  You still need to do the page to virtual translation, 
> which kmap_atomic does for you.

Fair enough.

Ben.
