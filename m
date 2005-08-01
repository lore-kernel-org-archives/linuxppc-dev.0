Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B19ED67E2A
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2005 04:18:14 +1000 (EST)
Date: Mon, 1 Aug 2005 11:18:11 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: LinuxPPC dev list <linuxppc-dev@ozlabs.org>
Message-ID: <20050801181811.GA13627@gate.ebshome.net>
References: <20050801174238.GA31016@anthropohedron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050801174238.GA31016@anthropohedron.net>
Subject: Re: endianness of Linux kernel RAID
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 01, 2005 at 01:42:39PM -0400, Gregory Seidman wrote:
> It turns out that if one uses the kernel (2.4.x-2.6.x) RAID support (RAID5,
> anyway, since that's all I've tested), the RAID'd disks cannot be moved to
> another system with a different endianness. I don't know how hard that
> would be to fix, but it did mean that when my ancient Mac clone I was using
> as a server died I couldn't bring the RAID over to my spare x86 Linux box;
> I had to dedicate other hardware (my dual G4 that I had been happily using
> with OS X) to the task instead.
> 
> Unfortunately, I haven't gotten into kernel development and, therefore, do
> not have the necessary expertise to fix it. Is anyone here interested in
> this issue?

It's a known Linux sw RAID problem. Please, bug RAID maintainers, not 
PPC people, as it's not a Linux PPC problem - RAID code is completely 
generic one.

-- 
Eugene
