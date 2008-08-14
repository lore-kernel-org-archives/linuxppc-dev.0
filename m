Return-Path: <dgibson@ozlabs.org>
Date: Thu, 14 Aug 2008 23:36:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] libfdt: Add support for using aliases in
	fdt_path_offset()
Message-ID: <20080814133608.GF32158@yookeroo.seuss>
References: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0808140827220.2701@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 14, 2008 at 08:28:19AM -0500, Kumar Gala wrote:
> If the path doesn't start with '/' check to see if it matches some alias
> under "/aliases" and substitute the matching alias value in the path
> and retry the lookup.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
