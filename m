Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C6AB0B6F85
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 07:19:55 +1100 (EST)
Received: from mail162-va3 (localhost [127.0.0.1])	by
 mail162-va3-R.bigfish.com (Postfix) with ESMTP id 90CAA3C0152	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 20:19:32 +0000 (UTC)
Received: from VA3EHSMHS010.bigfish.com (unknown [10.7.14.235])	by
 mail162-va3.bigfish.com (Postfix) with ESMTP id 42670580044	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2011 20:19:32 +0000 (UTC)
Message-ID: <4EB448E3.7090500@freescale.com>
Date: Fri, 4 Nov 2011 15:19:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 5/7] fsl_pmc: update device bindings
References: <1320410207-14537-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4456F.9020005@freescale.com>
In-Reply-To: <4EB4456F.9020005@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2011 03:05 PM, Scott Wood wrote:
> On 11/04/2011 07:36 AM, Zhao Chenhui wrote:
>> +  "fsl,p1022-pmc" should be listed for any chip whose PMC is
>> +  compatible, and implies lossless Ethernet capability during sleep.
>>  
>>    "fsl,mpc8641d-pmc" should be listed for any chip whose PMC is
>>    compatible; all statements below that apply to "fsl,mpc8548-pmc" also
>>    apply to "fsl,mpc8641d-pmc".
>>  
>>    Compatibility does not include bit assignments in SCCR/PMCDR/DEVDISR; these
>> -  bit assignments are indicated via the sleep specifier in each device's
>> -  sleep property.
>> +  bit assignments are indicated via the clock nodes.  Device which has a
>> +  controllable clock source should have a "clk-handle" property pointing
>> +  to the clock node.
> 
> Do we have any code to use this?
> 
> Normally that shouldn't matter, but we already an unused binding for
> this. :-)
> 
> Please provide rationale for doing it this way.  Ideally it should
> probably use whatever http://devicetree.org/ClockBindings ends up being.

OK, I see the code now.  Still could use some explanation.

-Scott
