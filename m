Return-Path: <B29882@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 3E9471007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2011 14:42:42 +1100 (EST)
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded
 boot_cpuid{, _phys}
Date: Fri, 16 Dec 2011 03:42:35 +0000
Message-ID: <CAEsOVNdb2RMJzW3syOzWmfdrnc_XBxOp4uwM+2VFbWFT=G-fTQ@mail.gmail.com>
References: <1322192477.32635.15.camel@pasglop>
 <1322540669-6834-1-git-send-email-msm@freescale.com>
 <1324005174.4875.0.camel@pasglop>
 <CAEsOVNcZPH_MJUdy0q7AjwomHTZhg2DoHSV+y9xatq-2SohC2A@mail.gmail.com>
 <1324006543.4875.1.camel@pasglop>
In-Reply-To: <1324006543.4875.1.camel@pasglop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 15, 2011 at 9:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>> This is 4/5 which is also waiting for your review.
>>
>> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-October/093474.html
>
> Ah missed that. This is FSL specific, I'd need Kumar and/or Scott's ack
> for that one.

I believe Kumar was waiting on your review of 5/5. I'll let you guys discus=
s.

-M=
