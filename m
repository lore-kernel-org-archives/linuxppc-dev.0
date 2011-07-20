Return-Path: <dgibson@ozlabs.org>
Date: Wed, 20 Jul 2011 23:49:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: [PATCH] powerpc: Fix build dependencies for epapr.c which needs
	libfdt.h
Message-ID: <20110720134907.GN6399@yookeroo.fritz.box>
References: <1311092564-10102-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311092564-10102-1-git-send-email-msm@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 19, 2011 at 11:22:44AM -0500, Matthew McClintock wrote:
> Currently, the build can (very rarely) fail to build because libfdt.h has
> not been created or is in the process of being copied.
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>

Looks sane to me.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
