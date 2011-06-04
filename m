Return-Path: <ronne@list.ru>
Received: from smtp19.mail.ru (smtp19.mail.ru [94.100.176.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A826BB6FB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 19:03:04 +1000 (EST)
Message-ID: <4DE9F4BE.1060208@list.ru>
Date: Sat, 04 Jun 2011 13:02:54 +0400
From: Andrey Gusev <ronne@list.ru>
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: PROBLEM: 2.6.39 =?UTF-8?B?ZG9lc27igJl0IGJvb3Qgb24gUE9XRVIgTUE=?=
	=?UTF-8?B?Qw==?=
References: <4DE0AA62.4070909@list.ru>	<20110603000012.4ce5c45f@Jay>	<1307068891.23876.2.camel@pasglop>	<1307070645.23876.9.camel@pasglop>
	<20110604003602.13bc1a55@Jay>
In-Reply-To: <20110604003602.13bc1a55@Jay>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

04.06.2011 02:36, Giuliano Pochini пишет:
> On Fri, 03 Jun 2011 13:10:45 +1000
> Benjamin Herrenschmidt<benh@kernel.crashing.org>  wrote:
>
>> On Fri, 2011-06-03 at 12:41 +1000, Benjamin Herrenschmidt wrote:
>>> On Fri, 2011-06-03 at 00:00 +0200, Giuliano Pochini wrote:
>>>> On Sat, 28 May 2011 11:55:14 +0400
>>>> Andrey Gusev<ronne@list.ru>  wrote:
>>>>
>>>>> Hi!
>>>>> A kernel 2.6.39 doesn't boot on my POWER MAC G4.
>>>> Same problem with my dual-G4 MDD. A few more infos:
>>>> The machine hangs just after the message "Returning from prom_init" (still
>>>> in the OF screen).
>>>> The kernel works fine with the option maxcpus=1, but it locks up as soon as
>>>> I try to enable the second CPU with echo 1>  /sys.../online.
>>> I just verified that current upstream 3.0-rc1+ does boot fine.
>> The fix is:
>>
>>    c560bbceaf6b06e52f1ef20131b76a3fdc0a2c19
>>    powerpc/4xx: Fix regression in SMP on 476
>> [...]
> Yes, that patch fixed the problem. Thanks.
>
>
The upstream 3.0-rc1 boots on my machine fine too.
