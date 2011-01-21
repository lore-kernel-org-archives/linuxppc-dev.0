Return-Path: <jdl@jdl.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Globally s/struct irq_host/struct irq_domain/ 
In-reply-to: <20110121171314.GD7477@angua.secretlab.ca> 
References: <E1Pd18R-0002d3-US@jdl.com>
	<20110121171314.GD7477@angua.secretlab.ca>
Date: Fri, 21 Jan 2011 11:19:10 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1PgKdi-0005fc-J5@jdl.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> 
> For this to make sense, it really needs to also rename irq_host_ops
> structure, the IRQ_HOST_MAP* #defines, and the irq_*_host functions.
> It also /should/ adjust the users of irq_domain to rename function
> local variables and structure members.  Otherwise there will be an
> even worse mismatch in naming.

Happy to do so, but last time we talked about this, we decided
not to do *that* aspect of the rename with this patch, and that
we'd get to it later with follow on patches once this step was done.

Your call; just let me know.

jdl
