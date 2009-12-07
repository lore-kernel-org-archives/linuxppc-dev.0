Return-Path: <duwe@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17136B6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Dec 2009 21:18:26 +1100 (EST)
From: Torsten Duwe <duwe@lst.de>
To: arun@linux.vnet.ibm.com
Subject: Re: [v10 PATCH 2/9]: cpuidle: cleanup drivers/cpuidle/cpuidle.c
Date: Mon, 7 Dec 2009 11:17:57 +0100
References: <20091202095427.GA27251@linux.vnet.ibm.com>
	<200912042320.01320.duwe@lst.de>
	<20091206051928.GA18300@linux.vnet.ibm.com>
In-Reply-To: <20091206051928.GA18300@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200912071117.58163.duwe@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 06 December 2009, Arun R Bharadwaj wrote:

> Peter objected to the idea of integrating this with the old pm_idle
> because it has already caused a lot of problems on x86 and we wouldn't
> want to be doing the same mistake on POWER. The discussion related to
> that could be found here http://lkml.org/lkml/2009/8/26/233

And BenH has sketched how it should be done on ppc, in that thread:
http://lkml.org/lkml/2009/8/26/624 AFAIS this comment is still valid for v10.

Not only I would like to understand what is the conceptual idea behind the 
other changes. Nothing wrong with cleanups, but there's got to be a purpose 
and benefits.

	Torsten
