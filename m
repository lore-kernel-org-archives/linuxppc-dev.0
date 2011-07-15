Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C783B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Jul 2011 19:05:53 +1000 (EST)
Subject: Re: [PATCH 0/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1310718056.2586.275.camel@twins>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310718056.2586.275.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jul 2011 19:05:23 +1000
Message-ID: <1310720723.4968.309.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Shan Hai <haishan.bai@gmail.com>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-07-15 at 10:20 +0200, Peter Zijlstra wrote:
> But but but but, that get_user_pages(.write=1, .force=0) should result
> in a COW break, getting our own writable page.
> 
> What is this e500 thing smoking that this doesn't work? 

Right. That should have triggered the cow & flushed the TLB entry.... 

Cheers,
Ben.
