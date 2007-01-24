Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9A61FDDF8F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 10:41:49 +1100 (EST)
Message-ID: <45B7EEB6.8060607@freescale.com>
Date: Wed, 24 Jan 2007 17:41:42 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 06/18] Make ft_node_add() accept and return NULL.
References: <20070124210709.GF10527@ld0162-tx32.am.freescale.net>
	<4EF444AA-B7C0-460D-BA0A-EEDC9E2E4812@kernel.crashing.org>
	<45B7D78E.5020704@freescale.com>
	<C498DBDF-5413-46CA-9A11-B625B009B53A@kernel.crashing.org>
In-Reply-To: <C498DBDF-5413-46CA-9A11-B625B009B53A@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> But doesn't ft_add_node() add a node to the tree?  If so,
> a NULL is most likely a program error. If not, some name
> change is in order /me thinks ;-)

No, it adds the node to the phandle->internal pointer lookup table (or 
returns the existing phandle if it's already there).  And yes, it could 
use a better name -- how about ft_node_to_phandle()?

-Scott
