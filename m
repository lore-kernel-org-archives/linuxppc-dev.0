Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6BAADDE21
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 07:21:56 +1100 (EST)
In-Reply-To: <9e4733910711141126k1bb896caoe40fb7204237fa85@mail.gmail.com>
References: <bfa0697f0711131539n228f9f21q7b2acc896499b80d@mail.gmail.com>
	<9e4733910711131556r23a38780q39baf15d85c0bd85@mail.gmail.com>
	<bfa0697f0711140731n20ccd8bdme2de6302848f5a4f@mail.gmail.com>
	<9AADA2CE-A7F0-4C88-BFCF-08D6C8DC09E0@kernel.crashing.org>
	<bfa0697f0711140949q4cf92442gcb4c1ecf7592b040@mail.gmail.com>
	<20071114175630.GA4547@loki.buserror.net>
	<9e4733910711141126k1bb896caoe40fb7204237fa85@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <679CE66E-DA80-45B6-BC44-DBC23A00B4A4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: I2C on mpc8248 / device tree
Date: Wed, 14 Nov 2007 14:21:34 -0600
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Alan Bennett <embedded@akb.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 14, 2007, at 1:26 PM, Jon Smirl wrote:

> On 11/14/07, Scott Wood <scottwood@freescale.com> wrote:
>> On Wed, Nov 14, 2007 at 10:49:13AM -0700, Alan Bennett wrote:
>>> ERk.
>>>   So if I needed to read values from four i2c devices (raw access  
>>> would be
>>> fine) and I need to get this working in a few days, how would you  
>>> suggest I
>>> proceed?  Kernel = 2.6.23+.
>>>
>>>   Do I need to start from scratch?
>>>
>>>   Start by using Jon's patch  (or are the 5200 i2c and the cpm2 i2c
>>> completely incompatible?)
>>
>> Start with the cpm i2c driver that Jochen Friedrich posted to
>> linuxppc-embedded.
>
> Sorry about the confusion I thought the mpc82xx chips had the same i2c
> core as the mpc52xx but I was not correct.

the 8241 and 8245 have it, but they are the only ones.

- k
