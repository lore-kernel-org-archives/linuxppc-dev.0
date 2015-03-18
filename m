Return-Path: <robherring2@gmail.com>
Received: from mail-we0-x22f.google.com (mail-we0-x22f.google.com
 [IPv6:2a00:1450:400c:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C8DE21A0013
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2015 00:06:22 +1100 (AEDT)
Received: by webcq43 with SMTP id cq43so31840739web.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 06:06:19 -0700 (PDT)
MIME-Version: 1.0
Sender: robherring2@gmail.com
In-Reply-To: <1426654054.6504.2.camel@ellerman.id.au>
References: <1426625193-5055-1-git-send-email-peter@hurleysoftware.com>
 <1426654054.6504.2.camel@ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Mar 2015 08:05:58 -0500
Message-ID: <CAL_JsqKOCy9gxC1xhVTY31agnE=gcRUQKWwLih4Q9UTUUSKkrg@mail.gmail.com>
Subject: Re: [PATCH] Revert "of: Fix premature bootconsole disable with
 'stdout-path'"
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Peter Hurley <peter@hurleysoftware.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Grant Likely <grant.likely@linaro.org>, Pranith Kumar <bobby.prani@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2015 at 11:47 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Tue, 2015-03-17 at 16:46 -0400, Peter Hurley wrote:
>> This reverts commit 2fa645cb2703d9b3786d850db815414dfeefa51d.
>>
>> The assumption that at least 1 preferred console will be registered
>> when the stdout-path property is set is invalid, which can result
>> in _no_ consoles.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>
> Grant/Rob, in case you didn't see it, this has caused a panic on at least one
> powerpc box. So would be nice if it could go in for 4.0.

Yes, I'm well aware of it and it will go in this week.

Rob
