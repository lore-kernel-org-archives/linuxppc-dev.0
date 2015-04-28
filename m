Return-Path: <j.anaszewski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64E391A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 19:10:15 +1000 (AEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0NNI00KFAESX5H10@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 28 Apr 2015 10:10:09 +0100 (BST)
Message-id: <553F4E70.3020604@samsung.com>
Date: Tue, 28 Apr 2015 11:10:08 +0200
From: Jacek Anaszewski <j.anaszewski@samsung.com>
MIME-version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com> <20150423161342.55e9ac8f@ja.home>
 <m3egnama5l.fsf@oc8180480414.ibm.com> <20150424121629.69a159b3@ja.home>
 <m3zj5slovt.fsf@oc8180480414.ibm.com>
In-reply-to: <m3zj5slovt.fsf@oc8180480414.ibm.com>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jacek Anaszewski <j.anaszewski81@gmail.com>, cooloney@gmail.com,
 rpurdie@rpsys.net, linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2015 08:59 AM, Stewart Smith wrote:
> Jacek Anaszewski <j.anaszewski81@gmail.com> writes:
>> Is the DT node we are discussing used by some other drivers than the
>> LED class driver? Or is it required in this form by other components of
>> your platform?
>
> OS kernels are the chief consumers, Linux being the overwhelmingly major
> one here.
>
> But this is what firmware currently produces.
>
> Changing the DT representation at this stage is perhaps *possible*
> without creating a bunch of pain (I'd have to audit a bunch of things to
> see if we have GA shipping systems with this functionality for instance,
> and then evaluate the impact to partners and our various labs) which is
> a lot of work I don't particularly want to do and is well below urgent
> item 248 on my TODO list, especially for what seems to be largely a
> cosmetic suggestion?
>
> That being said, more and better review of things we're putting in the
> device tree in firmware is probably a good thing. After all, once we
> release we do kind of have to live with it essentially forever. If
> people are able to aid in that kind of code review, I'd be most welcome
> to hear it.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

As we agreed with Ben - DT bindings are platform specific and they will
have to be acked by powerpc maintainers. I have only DT related
experience from ARM based platforms, but it seems not to be applicable
to powerpc.

-- 
Best Regards,
Jacek Anaszewski
