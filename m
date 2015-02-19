Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D26E41A09C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 11:44:55 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 18 Feb 2015 17:44:53 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C8EB53E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 17:44:24 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1J0iiI341746492
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 17:44:52 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1J0iHEd013404
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 17:44:17 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 0/3] powerpc/powernv: Correctly detect optional OPAL calls
In-Reply-To: <54E445CC.9090304@linux.vnet.ibm.com>
References: <1424217824-30596-1-git-send-email-stewart@linux.vnet.ibm.com>
 <54E445CC.9090304@linux.vnet.ibm.com>
Date: Thu, 19 Feb 2015 11:43:57 +1100
Message-ID: <m38ufuhgs2.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vasant Hegde <hegdevasant@linux.vnet.ibm.com> writes:
> On 02/18/2015 05:33 AM, Stewart Smith wrote:
>> This series fixes three possible warnings that OPAL firmware would emit
>> when booting on hardware/simulator that didn't support certain functionality.
>> 
>> The correct thing for Linux to do is to detect firmware capability
>> by using the OPAL_CHECK_TOKEN call or examining device tree. In the case
>> of these three warnings, it was OPAL_CHECK_TOKEN.
>
> Stewart,
>   Sorry.. I couldn't makeout any difference between this patchset and earlier
> patchset which I had Acked except the update in cover page... (sub: Silence
> "OPAL called with invalid token" errors ).
>
>   Did I miss anything ?

You missed that I forgot I'd sent the patchset. :)
