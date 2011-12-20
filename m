Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6E7FDB6FEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 06:28:06 +1100 (EST)
Message-ID: <4EF0E1BB.5020208@freescale.com>
Date: Tue, 20 Dec 2011 13:27:55 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: McClintock Matthew-B29882 <B29882@freescale.com>
Subject: Re: [PATCH v2] powerpc/setup_{32, 64}.c: remove unneeded boot_cpuid{,
 _phys}
References: <1322192477.32635.15.camel@pasglop>
 <1322540669-6834-1-git-send-email-msm@freescale.com>
 <1324005174.4875.0.camel@pasglop>
 <CAEsOVNcZPH_MJUdy0q7AjwomHTZhg2DoHSV+y9xatq-2SohC2A@mail.gmail.com>
 <1324006543.4875.1.camel@pasglop> <4EEBB84C.2050001@freescale.com>
 <CAEsOVNdAhx+X3GFFtNO4XYC96OUyQF7uBePxGEE7RJ=BkTOAGA@mail.gmail.com>
In-Reply-To: <CAEsOVNdAhx+X3GFFtNO4XYC96OUyQF7uBePxGEE7RJ=BkTOAGA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/20/2011 12:44 PM, McClintock Matthew-B29882 wrote:
> On Fri, Dec 16, 2011 at 3:29 PM, Scott Wood <scottwood@freescale.com> wrote:
>> It would be nice if we could eliminate all usage of the boot cpu dtb
>> field -- it's easy to forget to set it, especially if you're not making
>> an AMP config.  The default -1 means this patch would break booting with
>> such a tree.
> 
> I can add a check here to see if the boot cpu in the device tree is -1
> to assume this is the boot cpu in addition to the boot cpu matching
> the PIR. 

Won't that break on secondaries with a -1 dtb?

-Scott
