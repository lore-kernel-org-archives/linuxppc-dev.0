Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Mar 2010 11:24:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [v2 PATCH] of/flattree: Fix unhandled OF_DT_NOP tag when
	unflattening the device tree
Message-ID: <20100320002407.GA15222@yookeroo>
References: <20100319200049.5195.97171.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100319200049.5195.97171.stgit@angua>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 19, 2010 at 02:01:49PM -0600, Grant Likely wrote:
> From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> NOPs within the property section are skipped, but NOPs between
> OF_DT_END_NODE and OF_DT_BEGIN_NODE were not. My firmware NOPs out
> entire nodes depending on various environment parameters.
> 
> of_scan_flat_dt already handles NOP more generally.

Fwiw, there's a test program in the libfdt/dtc tree called "nopulate"
which will liberally spread NOPs through a device tree blob (one
between every other tag), which might be useful for testing this

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
