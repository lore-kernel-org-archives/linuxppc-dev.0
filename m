Return-Path: <Diana.Craciun@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 04E2014009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 00:16:50 +1000 (EST)
Message-ID: <5357CB33.4070207@freescale.com>
Date: Wed, 23 Apr 2014 17:16:19 +0300
From: Diana Craciun <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2] powerpc/fsl: Added binding for Freescale CoreNet
 coherency fabric (CCF)
References: <1397833917-12611-1-git-send-email-diana.craciun@freescale.com>
 <1397856821.1694.126.camel@snotra.buserror.net>
In-Reply-To: <1397856821.1694.126.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2014 12:33 AM, Scott Wood wrote:
> On Fri, 2014-04-18 at 18:11 +0300, Diana Craciun wrote:
>> From: Diana Craciun <Diana.Craciun@freescale.com>
>>
>> The CoreNet coherency fabric is a fabric-oriented, conectivity
>> infrastructure that enables the implementation of coherent, multicore
>> systems. The CCF acts as a central interconnect for cores,
>> platform-level caches, memory subsystem, peripheral devices and I/O host
>> bridges in the system.
>>
>> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
>> ---
>>   .../devicetree/bindings/powerpc/fsl/ccf.txt        | 36 ++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
>>
>> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
>> new file mode 100644
>> index 0000000..f0b7143
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
>> @@ -0,0 +1,36 @@
>> +Freescale CoreNet Coherency Fabric(CCF) Device Tree Binding
>> +
>> +DESCRIPTION
>> +
>> +The CoreNet coherency fabric is a fabric-oriented, connectivity infrastructure
>> +that enables the implementation of coherent, multicore systems.
>> +
>> +Required properties:
>> +
>> +- compatible : <string>
>> +		Must include "fsl,corenetX-cf", "fsl,corenet-cf" - CoreNet coherency
>> +		fabric version X
> Specify "fsl,corenet1-cf" and "fsl,corenet2-cf" rather than
> "fsl,corenetX-cf" (given there's nothing in a chip manual that you can
> correlate with the value of X), and provide example chips for each.

OK.

> Also specify that "fsl,corenet-cf" represents the registers that are
> common between the two versions (not arbitrary "fsl,corenetX-cf" -- if
> there's ever an "fsl,corenet3-cf" it may not be compatible with this),
> and is retained for compatibility reasons.
>

What do you mean by common?  There are the csdids and snoop ids 
registers which are common  between the two versions but only by name 
because the register format is not the same.

Diana
