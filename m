Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E884DDDF32
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:44:09 +1100 (EST)
Message-ID: <498722F4.3070800@semihalf.com>
Date: Mon, 02 Feb 2009 17:44:36 +0100
From: Grzegorz Bernacki <gjb@semihalf.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] Add support for the digsy MTC board.
References: <1233329630876-git-send-email-gjb@semihalf.com>	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>	<4986EC33.9000600@semihalf.com>
	<20090202111101.5f95bd8b@lappy.seanm.ca>
In-Reply-To: <20090202111101.5f95bd8b@lappy.seanm.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> On Mon, 02 Feb 2009 13:50:59 +0100
> "Grzegorz Bernacki" <gjb@semihalf.com> wrote:
> 
> 
>> I would like to have support for following devices in defconfig for
>> digsy:
>> - LXT PHY
>> - RTC DS1337
>> - EEPROM AT24
>> - MTD partitioning based on OF description
> 
> I am seeing a problem where if I enable CONFIG_EEPROM_LEGACY and
> CONFIG_EEPROM_AT24, then the at24 driver does not work. Would you mind
> trying that?
> 

I enabled CONFIG_EEPROM_LEGACY in my defconfig and I can see eeprom 
detected in dmesg and I can also read/write to it via file 
/sys/bus/i2c/devices/0-0050/eeprom.

regards,
Grzesiek
