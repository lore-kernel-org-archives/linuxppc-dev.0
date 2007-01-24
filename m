Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 7963DDE0DB
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 09:02:08 +1100 (EST)
Message-ID: <45B7D044.7020007@smiths-aerospace.com>
Date: Wed, 24 Jan 2007 16:31:48 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 05/18] Add ft_first_node().
References: <20070124210707.GE10527@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070124210707.GE10527@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Clean up some of the open-coded data structure references by providing a
> function to return a pointer to the first node in the tree.  This is only
> used in high-level functions trying to access the beginning of the tree,
> not in low-level code that is actually manipulating the data structure.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/boot/flatdevtree.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

Hi Scott,

Have you considered replacing flatdevtree.c with David Gibson's fdtlib? 
  The interface is a lot cleaner, which likely carries through to the 
underlying code.
<http://thread.gmane.org/gmane.linux.ports.ppc64.devel/12771/focus=12877>

Best regards,
gvb
