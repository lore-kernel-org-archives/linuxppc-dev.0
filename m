Return-Path: <hanjun.guo@linaro.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C35931A00B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 18:29:13 +1100 (AEDT)
Received: by mail-pa0-f48.google.com with SMTP id ey11so126344pad.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 00:29:11 -0700 (PDT)
Message-ID: <544F4550.701@linaro.org>
Date: Tue, 28 Oct 2014 15:27:12 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
Subject: Re: [RFC PATCH] dt:numa: adding numa node mapping for memory nodes.
References: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <A4205FCA-D4DE-48A4-B19F-58400A3FBF5C@codeaurora.org>
 <20140917193452.GD7983@leverpostej>
In-Reply-To: <20140917193452.GD7983@leverpostej>
Content-Type: text/plain; charset=UTF-8
Cc: "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "gpkulkarni@gmail.com" <gpkulkarni@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014-9-18 3:34, Mark Rutland wrote:
> On Wed, Sep 17, 2014 at 04:37:30PM +0100, Kumar Gala wrote:
>>
>> On Sep 17, 2014, at 1:56 AM, Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com> wrote:
>>
>>> From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>
>>> This patch adds property "nid" to memory node to provide the memory range to
>>> numa node id mapping.
>>>
>>> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>>>
>>> —
>>
>> Adding the PPC guys as they’ve been doing NUMA on IBM Power Servers
>> for years with OF/DT.  So we should really try and follow what they’ve
>> done.
> 
> Agreed.
> 
>>> Documentation/devicetree/bindings/numa.txt | 58 ++++++++++++++++++++++++++++++
>>> 1 file changed, 58 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/numa.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
>>> new file mode 100644
>>> index 0000000..c4a94f2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/numa.txt
>>> @@ -0,0 +1,58 @@
>>> +======================================================
>>> +numa id binding description
>>> +======================================================
>>> +
>>> +======================================================
>>> +1 - Introduction
>>> +======================================================
>>> +The device node  property "nid(numa node id)" can be added to memory
> 
> Why the quotes?
> 
>>> +device node to map the range of memory addresses as defined in property "reg".
>>> +The property "nid" maps the memory range to the numa node id, which is used to
>>> +find the local and remory pages on numa aware systems.
> 
> What is a "numa node id", exactly, and how is the OS intended to use it?

I think "Proximity Domain" would be more suitably, processors and memory or IOs
in the same domain will have better performance than crossing other domains.

Thanks
Hanjun
