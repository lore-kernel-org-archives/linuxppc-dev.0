Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FDD91A0A9C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 08:35:26 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 19 Mar 2015 15:35:23 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 511BE19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:26:27 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2JLZKRO36765884
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 14:35:20 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2JLZJEh012287
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 15:35:19 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/powernv: Add OPAL interfaces for accessing
 and modifying system LED states
In-Reply-To: <20150308111408.3759.70606.stgit@localhost.localdomain>
References: <20150308110558.3759.72635.stgit@localhost.localdomain>
 <20150308111408.3759.70606.stgit@localhost.localdomain>
Date: Thu, 19 Mar 2015 14:35:11 -0700
Message-ID: <m37fucpt68.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cooloney@gmail.com, rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> This patch registers the following two new OPAL interfaces calls
> for the platform LED subsystem. With the help of these new OPAL calls,
> the kernel will be able to get or set the state of various individual
> LEDs on the system at any given location code which is passed through
> the LED specific device tree nodes.
>
> 	(1) OPAL_LEDS_GET_INDICATOR     opal_leds_get_ind
> 	(2) OPAL_LEDS_SET_INDICATOR     opal_leds_set_ind
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>

I also just merged the skiboot side of these calls.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>


(well, it boots, interacts with firmware. I didn't go and look at the
LEDs themselves).
