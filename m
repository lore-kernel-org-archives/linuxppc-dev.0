Return-Path: <j.anaszewski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DC4781A0EF1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 18:13:53 +1000 (AEST)
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NQC0093M6E25L90@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 22 Jun 2015 09:03:38 +0100 (BST)
Message-id: <5587C159.3060706@samsung.com>
Date: Mon, 22 Jun 2015 10:03:37 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, linux-leds@vger.kernel.org,
 stewart@linux.vnet.ibm.com, j.anaszewski81@gmail.com, cooloney@gmail.com,
 rpurdie@rpsys.net, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v4 0/3] LED interface for PowerNV platform
References: <20150428100535.26912.29607.stgit@localhost.localdomain>
 <55792BB3.3000102@linux.vnet.ibm.com>
In-reply-to: <55792BB3.3000102@linux.vnet.ibm.com>
Content-type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2015 08:33 AM, Vasant Hegde wrote:
> On 04/28/2015 03:39 PM, Vasant Hegde wrote:
>> The following series implements LED driver for PowerNV platform.
>
> Ben, Michael,
>
> Can you please review/ACK this patchset?

Yeah, we are waiting for ppc maintainer's ack, also to clarify
DT related issues. Ben himself asked to wait for the ack in the
message [1]. We are waiting for almost two months now :)

[1] http://www.spinics.net/lists/linux-leds/msg03557.html

-- 
Best Regards,
Jacek Anaszewski
