Return-Path: <j.anaszewski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB8351A0CB0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 21:15:54 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NNG002ZCPYE1J60@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 27 Apr 2015 12:15:50 +0100 (BST)
Message-id: <553E1A65.5080409@samsung.com>
Date: Mon, 27 Apr 2015 13:15:49 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com> <20150423161342.55e9ac8f@ja.home>
 <1430086038.16571.78.camel@kernel.crashing.org> <553DE41A.5070703@samsung.com>
 <1430128435.16571.110.camel@kernel.crashing.org>
In-reply-to: <1430128435.16571.110.camel@kernel.crashing.org>
Content-type: text/plain; charset=UTF-8; format=flowed
Cc: stewart@linux.vnet.ibm.com, cooloney@gmail.com,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, rpurdie@rpsys.net,
 linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2015 11:53 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2015-04-27 at 09:24 +0200, Jacek Anaszewski wrote:
>> I was not aware that some other entity than the driver could be
>> interested in the information provided by DT node. I will no longer
>> object, provided that we will get an ack from DT maintainer.
>
> My understanding is that we no longer need bindings to be accepted by DT
> maintainers.

I've just skimmed through the patches in
Documentation/devicetree/bindings/powerpc and they indeed don't have
acks from DT maintainers.

> That being said, I would like to review this one before it is accepted,
> as I haven't had a chance to do so yet :-) (I was mostly responding to
> you, I haven't caught up with the full thread yet).
>
> Please wait for an ack from myself or Michael Ellerman (the two powerpc
> maintainers). Either that or provide your ack and we'll merge it via our
> tree if we are happy with it.

Since this driver is for LED subsystem it should better go via leds tree.

-- 
Best Regards,
Jacek Anaszewski
