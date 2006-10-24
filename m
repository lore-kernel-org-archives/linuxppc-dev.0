Return-Path: <nvbolhuis@aimsys.nl>
Received: from smtp-vbr4.xs4all.nl (smtp-vbr4.xs4all.nl [194.109.24.24])
	by ozlabs.org (Postfix) with ESMTP id 491E967B8B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 16:58:08 +1000 (EST)
Message-ID: <453DB97A.2020500@aimsys.nl>
Date: Tue, 24 Oct 2006 08:58:02 +0200
From: Norbert van Bolhuis <nvbolhuis@aimsys.nl>
MIME-Version: 1.0
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: MPC8xx CPM I2C interface driver
References: <452B626D.8050106@aimsys.nl>
	<20061023025001.45e821c3@localhost.localdomain>
In-Reply-To: <20061023025001.45e821c3@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

>>Is there no MPC8xx CPM I2C interface driver in (latest) linux v2.6 or
>>am I mistaken ?
>>There's no code for CONFIG_I2C_ALGO8XX.
> 
> The answer is - no, there is no stuff in the 2.6 kernel. I used to have the port from 2.4 a while ago (an 
> improvement to the patches posted here btw)  but had no chance to cleanup it and push through lm_sensors.
> 
> 
>>I've a MPC870 based board and I was hoping for a MPC8xx CPM I2C
>>interface driver to be there (allowing user applications to open and
>>read/write /dev/i2c-0)
>>
> 
> You should be able to locate sources in this list's archives. Ping me once more if not, I'll try to dig it out of my HDD then...
> 

Yes indeed. I got i2c-algo-8xx.c from 2005-August. Also in the mail archives there
are some patches to this file and the I2C RPX adapter (which is about the only one
using I2C algo 8xx).
Btw. One of the changes had to do with I2C RPX adapter not requesting the I2C IRQ
since I2C algo is already doing that.

Anyway, it all seems to work now.

Thanks.

N.

-- 
This message has been scanned for viruses and is believed to be clean
