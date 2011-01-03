Return-Path: <htejun@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by ozlabs.org (Postfix) with ESMTP id 9773CB7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 01:33:10 +1100 (EST)
Received: by qwj8 with SMTP id 8so13472589qwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 03 Jan 2011 06:33:08 -0800 (PST)
MIME-Version: 1.0
Sender: htejun@gmail.com
In-Reply-To: <4D21DD55.2000000@ru.mvista.com>
References: <201101031445.47922.roman.fietze@telemotive.de>
	<20110103135929.GO18831@htj.dyndns.org>
	<4D21DD55.2000000@ru.mvista.com>
Date: Mon, 3 Jan 2011 15:33:07 +0100
Message-ID: <AANLkTi=5TrmxeWppabYaFUr-AhLwWcn4b_EQgLSJT44T@mail.gmail.com>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
From: Tejun Heo <tj@kernel.org>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 3, 2011 at 3:29 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrot=
e:
>> The commit you bisected to contains all those conversions too. =A0Take a
>> look at a similar driver and look at how it has been converted
>> recently. =A0Even better, just send the driver upstream. =A0:-)
>
> =A0 It's already there...

Ouch, did I forget to convert it or was it a merge timing problem?
Anyways, sorry about that.  Please go ahead and fix it. :-)

--=20
tejun
