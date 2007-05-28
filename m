Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0FDBDDEA3
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:30:38 +1000 (EST)
Message-ID: <465B6611.1070107@itee.uq.edu.au>
Date: Tue, 29 May 2007 09:30:25 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
Subject: Re: Xilinx git tree at source.mvista.com
References: <46555294.6040104@ru.mvista.com>
	<465561A4.9020403@dlasys.net>	<46558E54.80909@ru.mvista.com>	<20070524154211.169C7AE8051@mail10-fra.bigfish.com>	<465640C1.1060206@dlasys.net>
	<20070525042616.35988808054@mail150-dub.bigfish.com>
In-Reply-To: <20070525042616.35988808054@mail150-dub.bigfish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	"David H. Lynch Jr." <dhlii@dlasys.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Wolfgang,

Wolfgang Reissnegger wrote:
> David H. Lynch Jr. wrote:
> 
>>For me the most significant issue is the bazillion layers of nested
>>macro's and includes.
> 
> 
> I don't see the macros as an issue, just look at the implementation of,
> for example, spin_lock_irq() and Xilinx's macros seem like child's play :-)
> As for includes, yes, there are a few too many header files. But, as
> time progresses and the need arises they can be merged into fewer files.

It seems the kernel.org decision has been made re: the style issue. 
None of the *_i.[ch], *_g.[ch] + adapter.c drivers will make it to 
mainline.

I understand why Xilinx did it this way, but to be honest never agreed 
with it myself either.  Style issues aside, three levels of function 
calls in an interrupt handler might be portable, but it still isn't a 
good thing!

The effort to refactor these drivers is not huge, but it is an effort. 
If Xilinx is committed to good quality Linux support for their silicon, 
it will require tangible investment in the form of labour or resources. 
I know you understand this, but Xilinx as an company still needs a good 
hard shove in this direction.

Alternatively, drivers will trickle into kernel.org as the community 
gets around to it, witness the uartlite and system ace drivers.

Same old story, if you want it "some day", then it will be free, if you 
want it now, you've got to pay!

Cheers,

John
