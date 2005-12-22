Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B74C1688F9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Dec 2005 02:50:38 +1100 (EST)
In-Reply-To: <001f01c6070d$649e8f00$34f1ff0a@beint.local>
References: <001f01c6070d$649e8f00$34f1ff0a@beint.local>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <85C67BBD-0072-4B64-A7B1-71871E755B76@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 22 Dec 2005 09:50:47 -0600
To: achim.machura@berghof.com
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>, "'Jenkins,
	Clive'" <Clive.Jenkins@xerox.com>
Subject: Re: AW: Kernel cmdline
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 22, 2005, at 9:35 AM, Achim Machura wrote:

>
>> Yes. Look at:
>> http://lxr.linux.no/source/init/main.c?v=2.6.10;a=ppc#L123
>> Clive
>
> Thanks,
>
> but this exaple seems to work only with modules staticly linked  
> into the
> kernel.
>
> I' ve to parse the commandline in a dynamic loaded modul.

Why would you want to do this.  Anyways, the cmd_line is to exported  
to modules.  You can provide modules there own params

- kumar
