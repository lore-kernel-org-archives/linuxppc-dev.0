Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.245])
	by ozlabs.org (Postfix) with ESMTP id 94295DE556
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 01:29:25 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so3397468agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 08:29:24 -0700 (PDT)
Message-ID: <fa686aa40806060829h52c5d27fvcec8c02c2eee3c7@mail.gmail.com>
Date: Fri, 6 Jun 2008 09:29:24 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
In-Reply-To: <20080603214232.E0A8D1488061@mail55-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080508161529.65566FB805F@mail185-va3.bigfish.com>
	<1210271125-11559-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080603214232.E0A8D1488061@mail55-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 3, 2008 at 3:41 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
> It appears that this turns out to interact badly with the probing of
> PPC_UDBG_16550, which is always enabled on PPC405 (and apparently
> found!) even though Virtex devices don't have them.

What is the symptom?

g.

>
> Steve
>
>> -----Original Message-----
>> From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]
>> Sent: Thursday, May 08, 2008 11:25 AM
>> To: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
> grant.likely@secretlab.ca; linuxppc-dev@ozlabs.org
>> Cc: Stephen Neuendorffer
>> Subject: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
>>
>> ePAPR drafts propose 'simple-bus' as a generic compatibility type for
>> busses which cannot be probed for devices.  In addition, the Xilinx
>> versions of these IPs seem to be proliferating.  Hence, in the future
>> let's prefer to use the standard names.  I've left the old names in
>> for short term backward compatibility for existing device trees.
>>
>> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>> ---
>>  arch/powerpc/platforms/40x/virtex.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/40x/virtex.c
> b/arch/powerpc/platforms/40x/virtex.c
>> index 6c72994..b1ab7b8 100644
>> --- a/arch/powerpc/platforms/40x/virtex.c
>> +++ b/arch/powerpc/platforms/40x/virtex.c
>> @@ -16,6 +16,7 @@
>>  #include <asm/xilinx_intc.h>
>>
>>  static struct of_device_id xilinx_of_bus_ids[] __initdata = {
>> +     { .compatible = "simple-bus", },
>>       { .compatible = "xlnx,plb-v46-1.00.a", },
>>       { .compatible = "xlnx,plb-v46-1.02.a", },
>>       { .compatible = "xlnx,plb-v34-1.01.a", },
>> --
>> 1.5.3.4

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
