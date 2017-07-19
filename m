Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCLkr0Fm0zDrWL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jul 2017 01:37:40 +1000 (AEST)
Received: from mail-yb0-f179.google.com (mail-yb0-f179.google.com
 [209.85.213.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E9CB922B67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 15:37:37 +0000 (UTC)
Received: by mail-yb0-f179.google.com with SMTP id w187so1092138ybc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 08:37:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <878tjkiqgs.fsf@concordia.ellerman.id.au>
References: <20170718214339.7774-6-robh@kernel.org>
 <878tjkiqgs.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Jul 2017 10:37:16 -0500
Message-ID: <CAL_Jsq+f04cbTxoJEz8DW+TnE+TTO++F6M5=kBkMJkbO-w211g@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Convert to using %pOF instead of full_name
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Anatolij Gustschin <agust@denx.de>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Arnd Bergmann <arnd@arndb.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 19, 2017 at 7:03 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Anatolij Gustschin <agust@denx.de>
>> Cc: Scott Wood <oss@buserror.net>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
> ...
>>  79 files changed, 464 insertions(+), 490 deletions(-)
>
>
> Is the plan that I'll merge this for 4.14 ?

Yes, hence why it's not a series and sent to you.

Rob
