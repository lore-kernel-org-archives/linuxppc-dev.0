Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A03091A0745
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 09:57:41 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 18:57:38 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 521F938C8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 18:57:36 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BMvZpS26607820
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 22:57:36 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BMvZJR000382
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 18:57:35 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [RFC PATCH 4/7]powerpc/powernv: Add OPAL support for Nest pmu
In-Reply-To: <1426079233-16720-5-git-send-email-maddy@linux.vnet.ibm.com>
References: <1426079233-16720-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1426079233-16720-5-git-send-email-maddy@linux.vnet.ibm.com>
Date: Thu, 12 Mar 2015 09:57:28 +1100
Message-ID: <m31tkvuopz.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ak@linux.intel.com, srivatsa@mit.edu, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> Nest Counters can be configured via PORE Engine and OPAL
> provides an interface call to it. PORE Engine also does the 
> work of moving the counter data to memory.  

Do you have the associated skiboot patch that implements this firmware
call? I haven't seen it on the skiboot list yet :)
