Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yD7Gd2vJZzDrCt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 00:04:41 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9DD0OJK010883
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 09:04:39 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2djtvbk5bn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 09:04:36 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Fri, 13 Oct 2017 09:03:05 -0400
Subject: Re: [PATCH] powerpc/powernv: Enable reset_devices parameter to issue
 a PHB reset
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, maurosr@linux.vnet.ibm.com
References: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
 <87fuantpdk.fsf@concordia.ellerman.id.au>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 10:02:58 -0300
MIME-Version: 1.0
In-Reply-To: <87fuantpdk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <5f9d3902-5982-7ea6-951f-10f2b90d00b4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2017 05:37 AM, Michael Ellerman wrote:
> 
> I really dislike this.
> 
> You're basically saying the kernel can't work out how to get a device
> working, so let's leave it up to the user.

Oh, it was never my intention to say such blasphemy :)
It meant to be just a debug option to help the users, specifically the
ones debugging drivers, to try using a hammer to recover bad devices! To
this issue that I mentioned as an example, the fix specifically goes in
the FW of the adapter.

Anyway, since you really dislike it, let's drop it, no big deal!
Cheers,


Guilherme

> 
> The driver should be fixed to detect that the device is not responding
> and request a reset.
> 
> cheers
> 
