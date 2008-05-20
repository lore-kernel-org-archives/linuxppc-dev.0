Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C9510DE23A
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 03:34:17 +1000 (EST)
Message-Id: <998DABA0-38B6-43C3-A788-307AA8D52F17@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Rune Torgersen" <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B046E73EC@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Oops in fs_enet driver with preempt-rt
Date: Tue, 20 May 2008 12:33:31 -0500
References: <DCEAAC0833DD314AB0B58112AD99B93B046E728C@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E72C3@ismail.innsys.innovsys.com>
	<4832F139.1020502@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E73C6@ismail.innsys.innovsys.com>
	<4832FA80.7060807@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B046E73EC@ismail.innsys.innovsys.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 11:31 AM, Rune Torgersen wrote:

> Scott Wood wrote:
>> Rune Torgersen wrote:
>>> Hmm.... ttyCPM1 output seems to be kinda garbled... Any ideas?
>>> Incomplete locking between printk and userland use of ttyCPM1 as
>>> console?
>>
>> s/incomplete/nonexistent/ :-P
>>
>> Try acquiring port->lock in cpm_uart_console_write.
>>
>> -Scott
>
> That worked. Console output is sane again.

I'm hoping to see some patches related to these fixes :)

- k
