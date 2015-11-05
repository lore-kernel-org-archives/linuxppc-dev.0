Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3FFC1A0C75
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 22:26:12 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 04:26:09 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C79E7C90042
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 06:14:18 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA5BQ8NB60686426
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 11:26:08 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA5BQ7f4017639
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 06:26:07 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: David Gibson <dgibson@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: thuth@redhat.com, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: on crash,
 kexec'ed kernel needs all CPUs are online
In-Reply-To: <20151105123243.47dda843@voom.fritz.box>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <5639FB4A.7020508@linux.vnet.ibm.com> <563A0E2B.4090404@redhat.com>
 <20151105123243.47dda843@voom.fritz.box>
Date: Thu, 05 Nov 2015 17:59:24 +1100
Message-ID: <m3mvut0w4z.fsf@oc8180480414.ibm.com>
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

David Gibson <dgibson@redhat.com> writes:
>> > opal/powernv:
>> > https://github.com/open-power/skiboot/commit/9ee56b5
>> 
>> Very interesting. Is there a way to have a firmware with the fix ?
>
> From Laurent's analysis of the crash, I don't think this will be
> relevant either, but I'm not sure.  It would be very interesting to
> know which (if any) released firmwares include this patch so we can
> test it.

It'll be on the (just released) IBM LC machines (the ones with the AMI
BMC) and will be in the next major firmware version for FSP based
machines (the -L machines) FW840, which should be out in the next
month. Let me know if you want a build of that, we should be able to get
one to you.

For any OpenPower machine you can always build a custom skiboot and
flash it :)
