Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 9A565B7092
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2011 11:55:24 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <dwg@au1.ibm.com>;
 Wed, 21 Dec 2011 00:52:22 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBL0tAsP4931704
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2011 11:55:10 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBL0t9Zq022384
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2011 11:55:10 +1100
Date: Wed, 21 Dec 2011 11:55:02 +1100
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
 flag
Message-ID: <20111221005502.GE5188@truffala.fritz.box>
References: <20111208111212.GB3720@in.ibm.com>
 <20111208112330.GB24484@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111208112330.GB24484@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 08, 2011 at 04:53:30PM +0530, K.Prasad wrote:
> While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> "features" member of "struct ppc_debug_info" to advertise support for the
> same on Book3E PowerPC processors.

Hrm.  I had assumed the reason there wasn't a feature bit for EXACT
originally was that EXACT breakpoints were *always* supposed to be
supported by the new interface.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
