Return-Path: <stef.van.os@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id 434EE2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 01:03:56 +1100 (EST)
Message-ID: <511B9D48.20104@prodrive.nl>
Date: Wed, 13 Feb 2013 15:03:52 +0100
From: Stef van Os <stef.van.os@prodrive.nl>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/1] powerpc/85xx: Board support for ppa8548
References: <1359920347-15340-1-git-send-email-stef.van.os@prodrive.nl>
 <510FD412.4000505@calxeda.com>
 <8D4EF5B0-BEC6-4114-88CF-166EB3A70A53@kernel.crashing.org>
In-Reply-To: <8D4EF5B0-BEC6-4114-88CF-166EB3A70A53@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur.tabi@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2013 09:09 PM, Kumar Gala wrote:
>
> On Feb 4, 2013, at 9:30 AM, Timur Tabi wrote:
>
>> On 02/03/2013 01:39 PM, Stef van Os wrote:
>>
>>> +	pci0: pci@fe0008000 {
>>> +		status = "disabled";
>>> +	};
>>> +
>>> +	pci1: pci@fe0009000 {
>>> +		status = "disabled";
>>> +	};
>>> +
>>> +	pci2: pcie@fe000a000 {
>>> +		status = "disabled";
>>> +	};
>>
>> I was hoping you'd follow my example and include a comment indicating why the PCI devices are all disabled.
>>
>>> +static void ppa8548_show_cpuinfo(struct seq_file *m)
>>> +{
>>> +	uint svid, phid1;
>>
>> Please don't used unsized integers for hardware registers.
>>
>> 	uint32_t svid, phid1;
>
>
> Stef,
>
> If you'd like this included for 3.9, please make the minor updates.
>
> thanks
>
> - k

Patches are on their way. Thanks!

Stef.
