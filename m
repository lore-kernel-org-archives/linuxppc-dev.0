Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59EAD1A0729
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 13:21:08 +1100 (AEDT)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 22:21:06 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id CC2FF38C8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 22:21:04 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t322L4Oi26148868
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 02:21:04 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t322L427015024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 22:21:04 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Add opal-prd channel
In-Reply-To: <1427868428.289931.158677373296.1.gpush@pablo>
References: <1427868428.289931.158677373296.1.gpush@pablo>
Date: Thu, 02 Apr 2015 13:21:01 +1100
Message-ID: <m3y4mb1d9u.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jeremy Kerr <jk@ozlabs.org> writes:

> This change adds a char device to access the "PRD" (processor runtime
> diagnostics) channel to OPAL firmware.
>
> Includes contributions from Vaidyanathan Srinivasan, Neelesh Gupta &
> Vishal Kulkarni.
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Acking that firmware interface is merged into skiboot and OPAL call
number is correct.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
