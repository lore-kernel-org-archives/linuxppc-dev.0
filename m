Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6318FDE03B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Mar 2007 02:01:08 +1100 (EST)
Date: Fri, 23 Mar 2007 10:00:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/17] Document the linux,network-index property.
Message-ID: <20070323150058.GA6060@ld0162-tx32.am.freescale.net>
References: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
	<36990c5c3b7de1ab2f65662547641b79@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302B97B1A@az33exm25.fsl.freescale.net>
	<4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4b0f0296e3beb792337a868c3527c954@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 07:57:33PM +0100, Segher Boessenkool wrote:
> >Segher, what is the the 'other alias' mechanism you are referring
> >to that should be dropped?  Is it this proposed linux,network-index
> >property?  or something else?
> 
> Just the
> 
> 	pic0: pic@700 {
> 		...
> 	}
> 
> labeling thing -- it becomes redundant when the flat tree
> stuff would support OF-style aliases, so it can be phased
> out then.

How?  You still need integer-encoded phandles, as that's how various
properties are defined.  Why should every node that needs a phandle
reference have to go in /aliases?  They seem to be solving two different
problems to me.

As for using aliases for network indices, it could be done, but it'd be
more complicated to implement due to string manipulation.

-Scott
