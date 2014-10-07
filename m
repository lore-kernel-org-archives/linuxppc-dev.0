Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4F2B1A01A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 15:37:01 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 6 Oct 2014 22:36:59 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D815819D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Oct 2014 22:25:39 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s974atOc39780424
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 06:36:55 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s974atS6017745
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Oct 2014 22:36:55 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/4] powerpc/powernv: Add OPAL check token call
In-Reply-To: <1408423682-14297-1-git-send-email-mikey@neuling.org>
References: <1408423682-14297-1-git-send-email-mikey@neuling.org>
Date: Tue, 07 Oct 2014 15:36:46 +1100
Message-ID: <m3y4ssfqch.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:
> Currently there is no way to generically check if an OPAL call exists or not
> from the host kernel.
>
> This adds an OPAL call opal_check_token() which tells you if the given token is
> present in OPAL or not.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

(checked the firmware code)

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

(although should we be checking if the call returns OPAL_PARAMETER?
The opal call will return that if booting on firmware without
OPAL_CHECK_TOKEN.. which granted, is pretty old firmware that I don't
*think* we had leave the lab... or at least not to too many places)
