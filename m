Return-Path: <Gavin.Shan@alcatel-lucent.com>
Received: from cnshjsmin03.cn.alcatel-lucent.com
	(cnmailgate04.alcatel-sbell.com.cn [211.144.215.47])
	by ozlabs.org (Postfix) with ESMTP id 91B56B7BE5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Dec 2009 09:47:55 +1100 (EST)
Message-ID: <4B335491.1020203@alcatel-lucent.com>
Date: Thu, 24 Dec 2009 06:46:25 -0500
From: gshan <gshan@alcatel-lucent.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [HELP] BAD interrupts
References: <9F4C7D19E8361D4C94921B95BE08B81BA09038@zin33exm22.fsl.freescale.net>
	<1261608230.3401.16.camel@concordia>
In-Reply-To: <1261608230.3401.16.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Kumar Gopalpet-B05799 <B05799@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2009-12-23 at 19:41 +0530, Kumar Gopalpet-B05799 wrote:
>   
>> Hi all,
>>  
>> I am trying linux 2.6.32-rc3 in SMP mode. I am seeing a lot of BAD
>> interrupts when I do a "cat  /proc/interrupts".
>>  
>> I am running a forwarding application b/w two ethernet ports (ethernet
>> uses gianfar driver).
>>  
>> Has any one observed these BAD interrupts ? If so, can someone help me
>> in understanding why these interrupts come and how to resolve it ?
>>     
>
> You'll need to tell us what platform you're running on.
>
> The BAD interrupts come from ppc_spurious_interrupts. It's a count of
> the number of times we entered do_IRQ() (ie. took an external
> interrupt), but when we asked the interrupt controller which irq it was,
> the interrupt controller said there was no irq.
>
> Depending on your interrupt controller that might happen sometimes for
> valid reasons. Or it might indicate something is setup wrong.
>
> cheers
>   
I think it will help to show us your /proc/interrupts so that how you 
suffered
from bad interrupts.
