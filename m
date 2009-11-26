Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 08/11] of: Merge of_node_get() and of_node_put()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20091124081918.6216.77775.stgit@angua>
References: <20091124081316.6216.66310.stgit@angua>
	<20091124081918.6216.77775.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:06:47 +1100
Message-ID: <1259208407.16367.233.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-11-24 at 01:19 -0700, Grant Likely wrote:

>  
> +#if !defined(CONFIG_SPARC)   /* SPARC doesn't do ref counting (yet) */
> +/**

Make this a Kconfig symbol, something like CONFIG_OF_DYNAMIC. You need
refcounting when you can add/remove nodes dynamically. Some embedded
archs might want the option to not enable that and save space.

Cheers,
Ben.
