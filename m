Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3EC41A0AAA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 08:55:22 +1000 (AEST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 16:55:20 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7FA251FF004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:46:27 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t5AMshvU30081248
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 15:54:43 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5AMtGth002105
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:55:17 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, joel@jms.id.au, vaibhav@linux.vnet.ibm.com,
 Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH v8] powerpc/powernv: Poweroff (EPOW,
 DPO) events support for PowerNV platform
In-Reply-To: <1433965909-9910-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1433965909-9910-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Thu, 11 Jun 2015 08:55:15 +1000
Message-ID: <m3fv5zdvho.fsf@oc8180480414.ibm.com>
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

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
> This patch adds support for FSP (Flexible Service Processor)
> EPOW (Early Power Off Warning) and DPO (Delayed Power Off) events for

Not restricted to FSP systems, it's a generic OPAL API that any platform
could implement.
