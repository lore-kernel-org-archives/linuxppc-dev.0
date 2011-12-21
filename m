Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6BA4EB7043
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2011 11:55:23 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <dwg@au1.ibm.com>;
 Wed, 21 Dec 2011 00:52:42 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pBL0t9Js4030704
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2011 11:55:09 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pBL0t9xf022372
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Dec 2011 11:55:09 +1100
Date: Wed, 21 Dec 2011 11:54:19 +1100
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] [hw-breakpoint] Use generic hw-breakpoint interfaces
 for new PPC ptrace flags
Message-ID: <20111221005419.GD5188@truffala.fritz.box>
References: <20111208111212.GB3720@in.ibm.com>
 <20111208111948.GA24484@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111208111948.GA24484@in.ibm.com>
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

On Thu, Dec 08, 2011 at 04:49:48PM +0530, K.Prasad wrote:
> PPC_PTRACE_GETHWDBGINFO, PPC_PTRACE_SETHWDEBUG and PPC_PTRACE_DELHWDEBUG are
> PowerPC specific ptrace flags that use the watchpoint register. While they are
> targeted primarily towards BookE users, user-space applications such as GDB
> have started using them for BookS too. This patch enables the use of generic
> hardware breakpoint interfaces for these new flags.
> 
> Apart from the usual benefits of using generic hw-breakpoint interfaces, these
> changes allow debuggers (such as GDB) to use a common set of ptrace flags for
> their watchpoint needs and allow more precise breakpoint specification (length
> of the variable can be specified).
> 
> Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>

Ok, I think it's finally ready to go.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
