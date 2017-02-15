Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNPcV6TmHzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 14:18:02 +1100 (AEDT)
Subject: Re: [PATCH 1/2] powerpc/powernv/opal-dump : Handles opal_dump_info
 properly
To: Mukesh Ojha <mukesh02@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
From: Jeremy Kerr <jk@ozlabs.org>
Message-ID: <c53b1b0e-848e-1821-03cc-de64c2f85dda@ozlabs.org>
Date: Wed, 15 Feb 2017 11:18:01 +0800
MIME-Version: 1.0
In-Reply-To: <1480583289-6380-1-git-send-email-mukesh02@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mukesh,

> Moves the return value check of 'opal_dump_info' to a proper place which
> was previously unnecessarily filling all the dump info even on failure.

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Thanks!


Jeremy
