Return-Path: <ulf.hansson@linaro.org>
Received: from mail-qk0-f179.google.com (mail-qk0-f179.google.com
 [209.85.220.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09E9C1A0276
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 19:49:16 +1000 (AEST)
Received: by qkx62 with SMTP id 62so2133729qkx.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2015 02:49:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpfiid4ny0fhw-yNfzCrynZnALNs+i51yeMhPneQ4XFFQ@mail.gmail.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <1430817426-5241-2-git-send-email-stripathi@apm.com>
 <CAPDyKFpfiid4ny0fhw-yNfzCrynZnALNs+i51yeMhPneQ4XFFQ@mail.gmail.com>
Date: Wed, 6 May 2015 11:49:14 +0200
Message-ID: <CAPDyKFo9qDG5xvw3uB3qmL1C5-j9M80k7o7ggvAqPHEFe=pXVg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Suman Tripathi <stripathi@apm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 Michal Simek <michal.simek@xilinx.com>, patches <patches@apm.com>,
 Don Dutile <ddutile@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5 May 2015 at 12:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 5 May 2015 at 11:17, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch adds the arasan sdhc nodes to reuse the of-arasan
>> driver for APM X-Gene SoC.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>
> I consider this one acked by Arnd, due to:
> http://www.spinics.net/lists/arm-kernel/msg415634.html
>
> Thus applied to my mmc tree.

According to follow up comments, I have dropped this patch from my tree for now.

Kind regards
Uffe
