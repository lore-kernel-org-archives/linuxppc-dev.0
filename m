Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC143B6FDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 08:43:34 +1000 (EST)
Subject: RE: powerpc: Add printk companion for ppc_md.progress
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Carroll <dcarroll@astekcorp.com>
In-Reply-To: <522F24EF533FC546962ECFA2054FF777373072AB9B@MAILSERVER2.cos.astekcorp.com>
References: <522F24EF533FC546962ECFA2054FF777373072AB9B@MAILSERVER2.cos.astekcorp.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 18 Jun 2011 08:43:04 +1000
Message-ID: <1308350584.32158.58.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"dtcarroll@gmail.com" <dtcarroll@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-17 at 10:03 -0600, Dave Carroll wrote:
> > On Fri, 2011-06-17 at 15:39 +1000, Benjamin Herrenschmidt wrote:
> >
> > Hrm.. none of your 2 pending patches applies cleanly (factoring
> > free_initmem & that one). Haven't had a chance to check why yet, can you
> > check on your side ?
> >
> Hi Ben,
> 
> I rebased with Linus' current tree, and the patches are identical. Is there another tree
> that I should use to get the patches clean?

Maybe they got corrupted by your mailer ? I will double check on monday.

Cheers,
Ben.
