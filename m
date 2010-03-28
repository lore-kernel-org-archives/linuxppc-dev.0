Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73CFBB7D08
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 00:07:38 +1100 (EST)
Message-ID: <4BAF54A1.3050509@embedded-sol.com>
Date: Sun, 28 Mar 2010 16:07:45 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCI bus rescan on 460EX
References: <4B8E6FA3.70503@embedded-sol.com>	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>	<4B9A07D2.4060801@jp.fujitsu.com>	<4B9AC885.3010107@embedded-sol.com>	<4B9DC820.2060100@jp.fujitsu.com>
	<4B9DCF01.4050709@embedded-sol.com>	<4B9DF72F.3040105@jp.fujitsu.com>
	<4B9E18A7.2080605@embedded-sol.com>	<4B9F19E2.2090709@jp.fujitsu.com>
	<4B9FFAD1.8030309@embedded-sol.com>	<4BA02A49.9050101@jp.fujitsu.com>
	<4BAF1DC2.2080600@embedded-sol.com>
	<1269770191.8599.329.camel@pasglop>
In-Reply-To: <1269770191.8599.329.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	yinghai@kernel.org, Alex Chiang <achiang@hp.com>, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Benjamin Herrenschmidt wrote:
> On Sun, 2010-03-28 at 12:13 +0300, Felix Radensky wrote:
>
>   
>> I've tried Jesse's tree with Yinghai's patches, but they don't seem to help.
>> Memory for bridge is not allocated after insertion of hotplug device and
>> bus rescan. Attached dmesg output in case of success and failure.
>>     
>
> I'd recommend that for now, your platform uses a quirk to manually
> resize the bridge resource to make room for future hotplug on it.
>
> Cheers,
> Ben.
>   

I've submitted a patch to do that. See 
https://patchwork.kernel.org/patch/88769

Felix.
