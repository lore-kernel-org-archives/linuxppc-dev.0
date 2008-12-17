Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0110DDF08
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 03:02:51 +1100 (EST)
Message-Id: <73ACB2AB-F90F-444D-BA44-2E547073569B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18760.21056.857206.703778@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
Date: Wed, 17 Dec 2008 10:00:42 -0600
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>
	<493E88B7.5020702@freescale.com>
	<20081209161422.5e289e6c@xilun.lan.proformatique.com>
	<493E8BE2.809@freescale.com>
	<20081214195050.677ba7d1@xilun.lan.proformatique.com>
	<18757.30913.736857.463769@cargo.ozlabs.ibm.com>
	<20081215013251.0359db80@xilun.lan.proformatique.com>
	<33EE789F-D0A8-40A0-BF2A-B8084613B431@kernel.crashing.org>
	<18760.21056.857206.703778@cargo.ozlabs.ibm.com>
Cc: Tjernlund <joakim.tjernlund@transmode.se>,
	Guillaume Knispel <gknispel@proformatique.com>,
	Pantelis Antoniou <pantelis@embeddedalley.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 16, 2008, at 7:13 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Paul are you planning on picking this up for .28 if not I'll pick it
>> up for .29
>
> I was waiting for you to say if it needed to go in .28.  Sounds like
> you don't think it's that urgent then?

Since I have another patch for .28 I'll include in my merge tree.

- k
