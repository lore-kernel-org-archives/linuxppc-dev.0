Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B4D61A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 21:20:09 +1100 (AEDT)
Date: Mon, 30 Mar 2015 11:20:01 +0100
From: Luis Henriques <luis.henriques@canonical.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: stable: Please include commit bb344ca5b90 ("powerpc/mpc85xx: Add
 ranges to etsec2 nodes")
Message-ID: <20150330102001.GB20509@charon.olymp>
References: <20150326211427.GA20872@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150326211427.GA20872@home.buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 26, 2015 at 04:14:27PM -0500, Scott Wood wrote:
> Commit bb344ca5b90df6 ("powerpc/mpc85xx: Add ranges to etsec2 nodes")
> fixes a bug that was exposed by commit 746c9e9f92dd ("of/base: Fix
> PowerPC address parsing hack").  The latter commit was applied to stable
> trees, so the former should be as well.
> 
> -Scott
> 
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks, I'll queue this fix for the 3.16 kernel.

Cheers,
--
Luís
