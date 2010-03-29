Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4ED65B7CF1
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 18:35:53 +1100 (EST)
Message-ID: <4BB0585F.2090906@embedded-sol.com>
Date: Mon, 29 Mar 2010 10:35:59 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>		<4B9AC885.3010107@embedded-sol.com>	<4B9DC820.2060100@jp.fujitsu.com>		<4B9DCF01.4050709@embedded-sol.com>	<4B9DF72F.3040105@jp.fujitsu.com>		<4B9E18A7.2080605@embedded-sol.com>	<4B9F19E2.2090709@jp.fujitsu.com>		<4B9FFAD1.8030309@embedded-sol.com>	<4BA02A49.9050101@jp.fujitsu.com>		<4BAF1DC2.2080600@embedded-sol.com>	<86802c441003281705v7d911553q4ee6f385c856644d@mail.gmail.com>
	<4BB0503D.5000700@jp.fujitsu.com>
In-Reply-To: <4BB0503D.5000700@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Alex Chiang <achiang@hp.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kenji-san,

Kenji Kaneshige wrote:
>
>
> Felix, I think assigning hpXXsize at boot time is the simpler solution,
> if it is acceptable workaround for you. And as Yinghai suggested in the
> another email, removing slot's parent bridge first should be one of the
> workaround. But the problem is whether it is acceptable for you, because
> your hotplug problem seems a regression.
>
> Thanks,
> Kenji Kaneshige
>
>

Both workarounds work for me, and will use hpXXsize as a short term
solution. In the long run I'd like to see the problem fixed properly and
I'm willing to test patches on my hardware, as I also think it's a 
regression.

Thanks Kenji-san and Yinghai for your help.

Felix.
