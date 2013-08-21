Return-Path: <B45939@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB2C82C0103
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 16:59:29 +1000 (EST)
Message-ID: <5214653E.4080105@freescale.com>
Date: Wed, 21 Aug 2013 14:59:10 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Vinod Koul <vinod.koul@intel.com>, <devicetree@vger.kernel.org>,
 <rob.herring@calxeda.com>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
 <swarren@wwwdotorg.org>, <ian.campbell@citrix.com>
Subject: Re: [PATCH v7 0/3] DMA: Freescale: Add support for 8-channel DMA
 engine
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <20130729105901.GI29095@intel.com> <521329EA.3050900@freescale.com>
 <20130820081522.GC5810@intel.com>
In-Reply-To: <20130820081522.GC5810@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-kernel@vger.kernel.org, grant.likely@linaro.org, djbw@fb.com,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi DT maintainers,
Rob Herring, Pawel Moll, Mark Rutland, Stephen Warren, Ian Campbell, 
could you please have a look at [1/3] and [2/3] of these patch set.
These patches have been fully reviewed by Scott Wood, and the DMA 
maintainer Vinod needs a Acted-by: from DT maintainers.
Thanks.

On 08/20/2013 04:15 PM, Vinod Koul wrote:
> On Tue, Aug 20, 2013 at 04:33:46PM +0800, Hongbo Zhang wrote:
>> On 07/29/2013 06:59 PM, Vinod Koul wrote:
>>> On Mon, Jul 29, 2013 at 06:49:01PM +0800, hongbo.zhang@freescale.com wrote:
>>>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>>
>>>> Hi Vinod, Dan, Scott and Leo, please have a look at these V7 patches.
>>> The dma relates changes look okay to me.
>>>
>>> I need someone to review and ACK the DT bindings.
>>>
>>> ~Vinod
>> Vinod,
>> Are you using this tree?
>> http://git.infradead.org/users/vkoul/slave-dma.git
> Yes
>
>> Did you merge these patches?
> No
>
> As I said I would like someone who know DT and dma binding to ack them. I see
> devicetree ML has been cced, can Arnd or someone else review these...
>
> ~Vinod
>
