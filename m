Return-Path: <sshtylyov@mvista.com>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by ozlabs.org (Postfix) with ESMTP id 39D1EB7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 02:28:52 +1100 (EST)
Received: by ewy19 with SMTP id 19so5607520ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Jan 2011 07:28:50 -0800 (PST)
Message-ID: <4D21EAF1.2010504@ru.mvista.com>
Date: Mon, 03 Jan 2011 18:27:45 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
References: <201101031445.47922.roman.fietze@telemotive.de>	<20110103135929.GO18831@htj.dyndns.org>	<4D21DD55.2000000@ru.mvista.com>
	<AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
In-Reply-To: <AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 03-01-2011 17:33, Tejun Heo wrote:

>>> The commit you bisected to contains all those conversions too.  Take a
>>> look at a similar driver and look at how it has been converted
>>> recently.  Even better, just send the driver upstream.  :-)

>>    It's already there...

> Ouch, did I forget to convert

    It probably wasn't obvious as this driver had lived in non-BMDMA section 
of Kconfig before the recent patch:

http://marc.info/?l=linux-ide&m=129303304605907

> it or was it a merge timing problem?
> Anyways, sorry about that.  Please go ahead and fix it. :-)

WBR, Sergei
