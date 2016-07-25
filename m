Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryZlV5cnMzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:52:54 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id y134so11559386pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 01:52:54 -0700 (PDT)
Date: Mon, 25 Jul 2016 16:52:49 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>,
 "cyrilbur@gmail.com" <cyrilbur@gmail.com>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
Message-ID: <20160725085248.GA4354@simonLocalRHEL7.x64>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
 <1467898167.27157.47.camel@kernel.crashing.org>
 <577f7a45.568f6b0a.bd0eb.4aa8SMTPIN_ADDED_BROKEN@mx.google.com>
 <20160715071546.GA5290@simonLocalRHEL7.x64>
 <5790aa9c.05296b0a.adf58.5901SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5790aa9c.05296b0a.adf58.5901SMTPIN_ADDED_BROKEN@mx.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thu, Jul 21, 2016 at 08:57:29PM +1000, Michael Ellerman wrote:
> Can one of you send a properly formatted and signed-off patch.

I will work on that.

Thanks,
Simon
