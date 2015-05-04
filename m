Return-Path: <stripathi@apm.com>
Received: from mail-wg0-f47.google.com (exprod5og115.obsmtp.com [64.18.0.246])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 870CC1A02EB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 16:03:22 +1000 (AEST)
Received: by wgyo15 with SMTP id o15so139543310wgy.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 May 2015 23:03:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
References: <1430456052-8888-1-git-send-email-stripathi@apm.com>
 <1430456052-8888-4-git-send-email-stripathi@apm.com>
 <f442e594-ac5c-4e77-ab80-3055fb791066@BN1AFFO11FD021.protection.gbl>
Date: Mon, 4 May 2015 11:33:17 +0530
Message-ID: <CAOHikRBbOYHOmnzA6Ycu6hwdNL6SgmXKVK0NLtJQfJL9KULuxg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Documentation: mmc: Update Arasan SDHC
 documentation to support 4.9a version of Arasan SDHC controller.
From: Suman Tripathi <stripathi@apm.com>
To: Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, May 4, 2015 at 11:30 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 05/01/2015 06:54 AM, Suman Tripathi wrote:
>> This patch updates Arasan SDHC documentation to support
>> 4.9a version of Arasan SDHC controller.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> index 98ee2ab..f01d41a 100644
>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
>> @@ -8,7 +8,8 @@ Device Tree Bindings for the Arasan SDHCI Controller
>>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>>
>>  Required Properties:
>> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
>> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
>> +                'arasan,sdhci-4.9a'
>>    - reg: From mmc bindings: Register location and length.
>>    - clocks: From clock bindings: Handles to clock inputs.
>>    - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>> @@ -18,7 +19,7 @@ Required Properties:
>>
>>  Example:
>>       sdhci@e0100000 {
>> -             compatible = "arasan,sdhci-8.9a";
>> +             compatible = "arasan,sdhci-8.9a", "arasan,sdhci-4.9a";
>
> Is there any reason to change this example?

Thought that if dts is updated so why not update the binding too.

> You probably want to have just one compatible string not both.

Okay will remove in next version.

>
> Thanks,
> Michal
>
>
>
>



-- 
Thanks,
with regards,
Suman Tripathi
