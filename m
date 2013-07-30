Return-Path: <B45939@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 12AFA2C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 12:10:12 +1000 (EST)
Message-ID: <51F72081.8060803@freescale.com>
Date: Tue, 30 Jul 2013 10:10:09 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v7 2/3] DMA: Freescale: Add new 8-channel DMA engine device
 tree nodes
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
 <1375135852.30721.60@snotra>
In-Reply-To: <1375135852.30721.60@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 06:10 AM, Scott Wood wrote:
> On 07/29/2013 05:49:03 AM, hongbo.zhang@freescale.com wrote:
>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>
>> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this 
>> patch adds
>> the device tree nodes for them.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
>> ---
>>  .../devicetree/bindings/powerpc/fsl/dma.txt        |   66 
>> ++++++++++++++++
>>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    4 +-
>>  arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   81 
>> ++++++++++++++++++++
>>  arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   81 
>> ++++++++++++++++++++
>>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
>>  5 files changed, 232 insertions(+), 4 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
>>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
>
> ACK
Thank you Scott for all the review comments.
>
> -Scott
