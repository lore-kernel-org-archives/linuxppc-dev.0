Return-Path: <davem@davemloft.net>
Date: Tue, 24 Nov 2009 14:22:42 -0800 (PST)
Message-Id: <20091124.142242.46843869.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH v2 11/11] of: unify phandle name in struct device_node
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091124215908.559.23998.stgit@angua>
References: <20091124215908.559.23998.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 24 Nov 2009 15:01:14 -0700

> In struct device_node, the phandle is named 'linux_phandle' for PowerPC
> and MicroBlaze, and 'node' for SPARC.  There is no good reason for the
> difference, it is just an artifact of the code diverging over a couple
> of years.  This patch renames both to simply .phandle.
> 
> Note: the .node also existed in PowerPC/MicroBlaze, but the only user
> seems to be arch/powerpc/platforms/powermac/pfunc_core.c.  It doesn't
> look like the assignment between .linux_phandle and .node is
> significantly different enough to warrant the separate code paths
> unless ibm,phandle properties actually appear in Apple device trees.
> 
> I think it is safe to eliminate the old .node property and use
> linux_phandle everywhere.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: David S. Miller <davem@davemloft.net>
