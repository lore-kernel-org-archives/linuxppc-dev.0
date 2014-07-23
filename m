Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B4F51A03E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 22:16:43 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 06:16:41 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5DCEE19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 06:16:28 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6NCFONO2294150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:15:24 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6NCGcsL013767
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 06:16:38 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/powernv: Improve error message
In-Reply-To: <20140723092246.4740.47235.stgit@hegdevasant.in.ibm.com>
References: <20140723092236.4740.33763.stgit@hegdevasant.in.ibm.com>
 <20140723092246.4740.47235.stgit@hegdevasant.in.ibm.com>
Date: Wed, 23 Jul 2014 22:16:27 +1000
Message-ID: <m3d2cwi82s.fsf@oc8180480414.ibm.com>
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

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> Presently we only support initiating Service Processor dump from host.
> Hence update sysfs message. Also update couple of other error/info
> messages.
>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
