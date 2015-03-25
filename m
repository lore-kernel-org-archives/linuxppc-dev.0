Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D058D1A1B66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:47:38 +1100 (AEDT)
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0B369140119
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 16:47:37 +1100 (AEDT)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 01:47:35 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A36B638C8039
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 01:47:33 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2P5lP2g25690114
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 05:47:33 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2P5l0Y6010078
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 01:47:00 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Remove powernv RTAS support
In-Reply-To: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
References: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
Date: Wed, 25 Mar 2015 16:46:42 +1100
Message-ID: <m3mw317hod.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> The powernv code has some conditional support for running on bare metal
> machines that have no OPAL firmware, but provide RTAS.
>
> No released machines ever supported that, and even in the lab it was
> just a transitional hack in the days when OPAL was still being
> developed.
>
> So remove the code.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

The only current place I could think this could be remotely possible
would be in simulator... and we should instead make the OPAL calls work
properly in the simulator for all the RTAS functionality (that we care
about).

In related news.. I should poke the simulator guys.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
