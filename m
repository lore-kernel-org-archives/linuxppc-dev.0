Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E9F0DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 06:58:03 +1000 (EST)
Message-Id: <C4539258-D329-4751-B894-250063FA2595@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <20080618203639.DAD3E48804F@mail107-sin.bigfish.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: 44x defconfig directory
Date: Wed, 18 Jun 2008 15:57:58 -0500
References: <1207487181.6809.18.camel@vader.jdub.homelinux.org><73BD1263-F09B-4E08-AA77-BEBD67D91C58@kernel.crashing.org><1207709608.3996.0.camel@vader.jdub.homelinux.org><18428.24729.933714.665889@cargo.ozlabs.ibm.com>
	<47ecccf53807a949b54dede883137c6d@kernel.crashing.org>
	<20080618203639.DAD3E48804F@mail107-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 3:36 PM, John Linn wrote:

>
> I'm adding a new defconfig file to the new configs/44x directory and
> make doesn't seem to find it.
>
> I must be missing something as this seems simple.
>
> Should I have to specify 44x in the path (make ARCH=powerpc
> 44x/defconfig) as this does work?

if you have configs/44x/foo_defconfig

than you do:

make ARCH=powerpc 44x/foo_defconfig

- k
