Return-Path: <saikia.partha@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D47412C016F
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Jun 2013 21:00:47 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <saikia.partha@gmail.com>) id 1UpcK8-0001CK-6L
 for linuxppc-dev@ozlabs.org; Thu, 20 Jun 2013 03:42:40 -0700
Date: Thu, 20 Jun 2013 03:42:40 -0700 (PDT)
From: perth1415 <saikia.partha@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1371724960184-72625.post@n7.nabble.com>
In-Reply-To: <1371675646.9073.39@snotra>
References: <CABeCxOKXpgVaoigGBdCVo3tYgbfJnesNPOuOyTc0EKv_CTKoyg@mail.gmail.com>
 <1371675646.9073.39@snotra>
Subject: Re: DEBUG_PAGEALLOC on PPC not working (kernels 2.6-25, 3.0-34)
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

Hi Scott,

Thanks for the reply, though a bit disheartening :-)
My understanding on e500 MMU is not clear. It'd be nice if I could find some
way (may be ad-hoc) to debug some use-after-free page corruptions. SLAB
debug tells me the page was modified by someone after it was freed but
DEBUG_PAGEALLOC would have been more specific, as to tell me where exactly
it was getting modified.
Any debugging clues will be much appreciated.

Regards,
Partha



--
View this message in context: http://linuxppc.10917.n7.nabble.com/DEBUG-PAGEALLOC-on-PPC-not-working-kernels-2-6-25-3-0-34-tp72536p72625.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
