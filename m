Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E002EDDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 04:54:11 +1000 (EST)
Message-ID: <462FA3B9.5080008@freescale.com>
Date: Wed, 25 Apr 2007 13:53:45 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH][RFC][POWERPC] i2c: adds support for i2c bus on 8xx
References: <20070420082714.4f10f186@localhost.localdomain>	<20070423025709.GA28805@lixom.net>
	<462F8953.1020201@kernel.crashing.org>
In-Reply-To: <462F8953.1020201@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olof Johansson <olof@lixom.net>, Jean Delvare <khali@linux-fr.org>,
	lkml <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug wrote:
> i2c && 8xx combo never work with 2.6 at least in mainstream. That's why 
> related stuff were scheduled to removal by Jean even,
> before I came up with this stuff.
[snip]
>> This could all be done with an of_platform driver instead, and avoid 
>> the above.
>> (Someone else already suggested that I believe).
>>
>>   
> 
> I know i know. But it was decided, while both ppc/ and powerpc/ wander 
> around, platform devices way is preferrable.

The idea is to avoid regressions in arch/ppc; maintaining feature parity 
isn't necessary.  If, as you say above, 8xx i2c was already broken in 
2.6 (even in arch/ppc), then I see no reason not to go to an of_device 
right away.

> It is apparent why - so far only mpc885 is alive in arch/powerpc, and it 
> is not going to change soon for 8xx. 

Actually, I plan to do some arch/powerpc 8xx work over the next couple 
months, so hopefully it will change soon. :-)

-Scott
