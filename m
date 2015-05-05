Return-Path: <stripathi@apm.com>
Received: from mail-wg0-f49.google.com (exprod5og110.obsmtp.com [64.18.0.20])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80C3B1A115A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 18:42:36 +1000 (AEST)
Received: by wgin8 with SMTP id n8so174432553wgi.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2015 01:42:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqva7jioEpf1qBv+sSo9-ZWU69+wb9qTF1X+4cxOgf2uQ@mail.gmail.com>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
 <CAPDyKFqva7jioEpf1qBv+sSo9-ZWU69+wb9qTF1X+4cxOgf2uQ@mail.gmail.com>
Date: Tue, 5 May 2015 14:12:32 +0530
Message-ID: <CAOHikRAviwD=kPQpHeR5NCXdANWH8B+DqNW=qJQ0ACpeOppU2A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN
 SDHCI controller.
From: Suman Tripathi <stripathi@apm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
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

On Tue, May 5, 2015 at 2:06 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 May 2015 at 15:39, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
>>
>> v1 change:
>>  * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.
>>
>> v2 change:
>>  * Drop the IOMMU support and switching to PIO mode for arasan.
>>    controller integrated inside APM X-Gene SoC.
>>
>> v3 change:
>>  * Change the sdhci-of-arasan.c to support arasan4.9a.
>>  * Add quirks for arasan4.9a.
>>
>> v4 change:
>>  * Cleanup the Documentation and dts.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>
>> Suman Tripathi (3):
>>   arm64: dts: Add the arasan sdhc nodes in apm-storm.dtsi.
>>   mmc: host: arasan: Add the support for sdhci-arasan4.9a in
>>     sdhci-of-arasan.c
>>   Documentation: mmc: Update Arasan SDHC documentation to support 4.9a
>>     version of     Arasan SDHC controller.
>>
>>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  3 +-
>>  arch/arm64/boot/dts/apm-mustang.dts                |  4 ++
>>  arch/arm64/boot/dts/apm-storm.dtsi                 | 44 ++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-of-arasan.c                 |  7 ++++
>>  4 files changed, 57 insertions(+), 1 deletion(-)
>>
>
> Thanks!
>
> I have applied patch2 and patch3. Though, I decided to squash them
> into one patch and changed the commit message header a bit.
>
> I couldn't apply patch 1, so I guess that will be taken through arm soc?

why it couldn't be applied?? I made it in top of

git git://git.linaro.org/people/ulf.hansson/mmc.git

Is this not correct ??

>
> Kind regards
> Uffe



-- 
Thanks,
with regards,
Suman Tripathi
