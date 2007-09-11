Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 5CE0DDDE9A
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:09:09 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3689500pyi
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 10:09:08 -0700 (PDT)
Message-ID: <fa686aa40709111009j64925edag511078d88ff904c@mail.gmail.com>
Date: Tue, 11 Sep 2007 11:09:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Michal Simek" <Monstr@seznam.cz>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: FDT for Microblaze and PPC405
In-Reply-To: <2057.3992-23959-31980099-1189527824@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40709110901k11082946r626fc8532d47eab5@mail.gmail.com>
	<2057.3992-23959-31980099-1189527824@seznam.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 9/11/07, Michal Simek <Monstr@seznam.cz> wrote:
> Hi Grant,

(Adding linuxppc-dev mailing list to CC list because we're discussing
FDT issues)

> I made EDK repository file for generation dts file from Xilinx design. I sent it to Wolfgang and Steve this week.
> It is in the same config file as I use for configuration Microblaze for U-BOOT. If you want I can send you this repository files.

Yes, please do.

> And I start with redesigning Linux kernel for Microblaze. I ported some peripherals as timer and intc etc.
> But for some peripherals I need better configuration.
>
> I have no time to read information about fdt. Can you tell me what labels I can use?

Steve has already done a bunch of work in this direction on
microblaze, I would converse with him.

>
> For example emaclite driver needs information about turning on/off ping pong buffer...
>
> I would like to make this properly.

FDT design is just as much art as it is science.  It takes taste and
judgement to desgin a nice set of bindings.  Your best option is to
draft something and post it to the linuxppc-embedded mailing list for
review.

>
> And second question is on early console logs and timers setting. I read about aliases in FDT. I think that aliases can cover this setting.
> For example my design contain 4 serial line and I would like to know which serial line is set on early console.

You use the chosen node for this.  In the chosen node, you add a
property called "linux,stdout-path" which holds the path to your
console.  You can look at examples under arch/powerpc/boot/dts/*

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
