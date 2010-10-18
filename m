Return-Path: <liberty@extricom.com>
Received: from smtp.extricom.com (unknown [212.235.17.194])
	by ozlabs.org (Postfix) with SMTP id F1163B710E
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 22:48:56 +1100 (EST)
Message-ID: <4CBC332A.9090905@extricom.com>
Date: Mon, 18 Oct 2010 13:44:42 +0200
From: Eran Liberty <liberty@extricom.com>
MIME-Version: 1.0
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Freescale P2020 CPU Freeze over PCIe abort signal
References: <4CADBD7B.3000506@extricom.com>		<1286756363.2463.517.camel@pasglop>
	<4CB2E517.8020401@extricom.com>	<1286796721.5220.2.camel@pasglop>
	<4CBB4D80.3030007@extricom.com> <4CBC18D8.5060804@windriver.com>
In-Reply-To: <4CBC18D8.5060804@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tiejun.chen wrote:
> AFAIK we can set one bit on PEX_ERR_DISR to detect PCI Express completion
> time-out. If so one interrupt should be issued. But I'm not sure if this can fix
> your issue.
>
> Tiejun
>   
As I understand the problem, this will not help me as the CPU itself is 
on hold waiting for the assembly line to complete. It may give me enough 
to spot the faulty situation and crash the system... but I am aiming for 
an Enterprise grade product.  Crash/oops is not something I want to put 
into the system if I do not absolutely have to and I do have a hardware 
watch-dog that will pull me out if I do.

So just for the fun of it I am going to follow up on this PEX_ERR_DISR, 
but I do not see how it will help.

-- Liberty
