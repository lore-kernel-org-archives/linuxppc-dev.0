Return-Path: <varkabhadram@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D98411A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 21:16:05 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id g10so1188987pdj.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Aug 2014 04:16:03 -0700 (PDT)
Message-ID: <53E0BC95.7040208@gmail.com>
Date: Tue, 05 Aug 2014 16:44:29 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <53E0B926.9010103@gmail.com> <20140805110735.GA16503@MrMyself>
In-Reply-To: <20140805110735.GA16503@MrMyself>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 Li.Xiubo@freescale.com, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2014 04:37 PM, Nicolin Chen wrote:
> Hi Varka,
>
> On Tue, Aug 05, 2014 at 04:29:50PM +0530, Varka Bhadram wrote:
>>> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
>>> index 0f4e238..77864f4 100644
>>> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
>>> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
>>> @@ -24,6 +24,22 @@ Required properties:
>>>   - big-endian-data: If this property is absent, the little endian mode will
>>>     be in use as default, or the big endian mode will be in use for all the
>>>     fifo data.
>>> +- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
>>> +  that SAI will work in the synchronous mode (sync Tx with Rx) which means
>>> +  both the transimitter and receiver will send and receive data by following
>>> +  receiver's bit clocks and frame sync clocks.
>>> +- fsl,sai-asynchronous: This is a boolean property. If present, indicating
>>> +  that SAI will work in the asynchronous mode, which means both transimitter
>>> +  and receiver will send and receive data by following their own bit clocks
>>> +  and frame sync clocks separately.
>>>
>> Would be readable if it like this...
>>
>> fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
>> 			that SAI will work in the synchronous mode (sync Tx with Rx) which means
>> 			both the transimitter and receiver will send and receive data by following
>> 			receiver's bit clocks and frame sync clocks.
>> - fsl,sai-asynchronous: This is a boolean property. If present, indicating
>> 			that SAI will work in the asynchronous mode, which means both transimitter
>> 			and receiver will send and receive data by following their own bit clocks
>> 			and frame sync clocks separately.
> I agree, however, the doc was initialized in that format. Adding
> indentations for these two appended lines makes the whole text
> look weird. :(

Reading comfortably is important for us...  :-)
see this:http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt#L46

Thanks....

-- 
Regards,
Varka Bhadram.
