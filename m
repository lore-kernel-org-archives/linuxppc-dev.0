Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95D241A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Oct 2014 08:28:43 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 80129140081
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2014 08:28:42 +1100 (AEDT)
Message-ID: <54515B8E.50100@Freescale.com>
Date: Wed, 29 Oct 2014 16:26:38 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v2 2/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
 portal(s)
References: <1414487751-31568-1-git-send-email-Emilian.Medve@Freescale.com>
 <1414487751-31568-3-git-send-email-Emilian.Medve@Freescale.com>
 <044D58B4-690A-4CEA-B2DB-8AF4549D4AE2__43711.2007676207$1414507333$gmane$org@codeaurora.org>
In-Reply-To: <044D58B4-690A-4CEA-B2DB-8AF4549D4AE2__43711.2007676207$1414507333$gmane$org@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 corbet@lwn.net, Geoff.Thorpe@Freescale.com, ijc+devicetree@hellion.org.uk,
 linux-doc@vger.kernel.org, scottwood@Freescale.com, linuxppc-dev@ozlabs.org,
 robh+dt@kernel.org, grant.likely@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar,


On 10/28/2014 09:41 AM, Kumar Gala wrote:
> On Oct 28, 2014, at 4:15 AM, Emil Medve <Emilian.Medve@freescale.com> wrote:
> 
>> Portals are memory mapped interfaces to BMan that allow low-latency,
>> lock-less interaction by software running on processor cores, accelerators
>> and network interfaces with the BMan
>>
>> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
>> Change-Id: I6d245ffc14ba3d0e91d403ac7c3b91b75a9e6a95
>> ---
>> .../bindings/powerpc/fsl/bman-portals.txt          | 52 ++++++++++++++++++++++
>> 1 file changed, 52 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt
>>
>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt b/Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt
> 
> similar comment about location of binding not being PPC specific.

Will move it to Documentation/devicetree/bindings/soc

>> new file mode 100644
>> index 0000000..02e0231
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/bman-portals.txt
>> @@ -0,0 +1,52 @@
>> +QorIQ DPAA Buffer Manager Portals Device Tree Binding
>> +
> 
> Probably worth putting the text from the commit message here as well.

Ok


Cheers,
