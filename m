Return-Path: <sshtylyov@mvista.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 73183B6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 03:34:25 +1100 (EST)
Received: by ewy19 with SMTP id 19so5630395ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Jan 2011 08:34:22 -0800 (PST)
Message-ID: <4D21FA4D.3030506@mvista.com>
Date: Mon, 03 Jan 2011 19:33:17 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>, Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
References: <201101031445.47922.roman.fietze@telemotive.de>	<20110103135929.GO18831@htj.dyndns.org>	<4D21DD55.2000000@ru.mvista.com>
	<AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
	<4D21EAF1.2010504@ru.mvista.com>
In-Reply-To: <4D21EAF1.2010504@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 03-01-2011 18:27, Sergei Shtylyov wrote:

>>>> The commit you bisected to contains all those conversions too. Take a
>>>> look at a similar driver and look at how it has been converted
>>>> recently. Even better, just send the driver upstream. :-)

>>> It's already there...

>> Ouch, did I forget to convert

> It probably wasn't obvious as this driver had lived in non-BMDMA section of
> Kconfig before the recent patch:

> http://marc.info/?l=linux-ide&m=129303304605907

>> it or was it a merge timing problem?
>> Anyways, sorry about that. Please go ahead and fix it. :-)

    Looks like the commit that added DMA support should be thanked for the 
mischief:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6b61e69e7bc1cfe80ab54c6321f19061f9487ed3

WBR, Sergei
