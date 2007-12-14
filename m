Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7FD42DDF34
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:58:06 +1100 (EST)
Message-Id: <A388C2C2-2452-4E70-A5DA-F61B0E3A2B22@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071208003604.GH566@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [DTC][PATCH] Fix cross-compile building
Date: Thu, 13 Dec 2007 23:57:48 -0600
References: <Pine.LNX.4.64.0712071227280.1788@blarg.am.freescale.net>
	<20071208003604.GH566@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>, stuarth@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2007, at 6:36 PM, David Gibson wrote:

> On Fri, Dec 07, 2007 at 12:28:20PM -0600, Kumar Gala wrote:
>> From: Stuart Hughes <stuarth@freescale.com>
>>
>> This patch allows you to build the DTC source without making the
>> tests directory.  This is necessary when cross compiling as the
>> dumptest (and other) files cannot be run/used on the host system.
>> To use this use: 'make TESTS='
>
> I think this is a silly way of doing this.  Instead create a new
> target which builds everything but the tests.
>
> Say,
>
> 	all: cross tests
>
> 	cross: dtc ftdump libfdt

shouldn't we do this the other way around, it seems odd to build the  
tests always or at least as part of the all target.

- k
