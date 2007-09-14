Return-Path: <monstr@seznam.cz>
Received: from service2.sh.cvut.cz (service2.sh.cvut.cz [147.32.127.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "service2.sh.cvut.cz",
	Issuer "Silicon Hill CA root certificate" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 40859DDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 05:52:12 +1000 (EST)
Message-ID: <000001c7f897$1899ef00$5d722093@monstrone>
From: "Michal Simek" <monstr@seznam.cz>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-dev" <linuxppc-dev@ozlabs.org>
References: <fa686aa40709110901k11082946r626fc8532d47eab5@mail.gmail.com>
	<2057.3992-23959-31980099-1189527824@seznam.cz>
	<fa686aa40709111009j64925edag511078d88ff904c@mail.gmail.com>
Subject: Re: FDT for Microblaze and PPC405
Date: Fri, 14 Sep 2007 21:35:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Reply-To: Michal Simek <monstr@seznam.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I made EDK tcl script for generation DTS test scructure for FDT. Script 
support Microblaze and PowerPC 405.
Script was primary built for generation U-BOOT configs files for Microblaze.
For Microblaze can you generate both files (FDT and U-BOOT).
For PowerPC can you generate only DTS file. Generation U-BOOT configs files 
aren't supported yet. Script ends after generation DTS.
Script has 2.00.a mark.
It is available at www.monstr.eu.

Cheers,
Michal Simek


> On 9/11/07, Michal Simek <Monstr@seznam.cz> wrote:
>> Hi Grant,
>
> (Adding linuxppc-dev mailing list to CC list because we're discussing
> FDT issues)
>
>> I made EDK repository file for generation dts file from Xilinx design. I 
>> sent it to Wolfgang and Steve this week.
>> It is in the same config file as I use for configuration Microblaze for 
>> U-BOOT. If you want I can send you this repository files.
>
> Yes, please do.
>
>> And I start with redesigning Linux kernel for Microblaze. I ported some 
>> peripherals as timer and intc etc.
>> But for some peripherals I need better configuration.
>>
>> I have no time to read information about fdt. Can you tell me what labels 
>> I can use?
>
> Steve has already done a bunch of work in this direction on
> microblaze, I would converse with him.
>
>>
>> For example emaclite driver needs information about turning on/off ping 
>> pong buffer...
>>
>> I would like to make this properly.
>
> FDT design is just as much art as it is science.  It takes taste and
> judgement to desgin a nice set of bindings.  Your best option is to
> draft something and post it to the linuxppc-embedded mailing list for
> review.
>
>>
>> And second question is on early console logs and timers setting. I read 
>> about aliases in FDT. I think that aliases can cover this setting.
>> For example my design contain 4 serial line and I would like to know 
>> which serial line is set on early console.
>
> You use the chosen node for this.  In the chosen node, you add a
> property called "linux,stdout-path" which holds the path to your
> console.  You can look at examples under arch/powerpc/boot/dts/*
>
> Cheers,
> g.
>
>
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>
>
> -- 
> No virus found in this incoming message.
> Checked by AVG Free Edition.
> Version: 7.5.485 / Virus Database: 269.13.15/1002 - Release Date: 
> 11.9.2007 05:46
>
> 
