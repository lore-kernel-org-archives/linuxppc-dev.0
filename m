Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 53104DDED5
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 03:09:12 +1000 (EST)
Message-ID: <4657182E.4060404@am.sony.com>
Date: Fri, 25 May 2007 10:09:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/7] ps3: Storage Driver Probing
References: <20070525083607.784351000@sonycom.com>	<20070525083632.474400000@sonycom.com>
	<200705251818.03964.arnd@arndb.de>
In-Reply-To: <200705251818.03964.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi.

Arnd Bergmann wrote:
>> +	switch (dev_type) {
>> +	case PS3_DEV_TYPE_STOR_DISK:
>> +		match_id = PS3_MATCH_ID_STOR_DISK;
>> +		break;
>> +
>> +	case PS3_DEV_TYPE_STOR_ROM:
>> +		match_id = PS3_MATCH_ID_STOR_ROM;
>> +		break;
>> +
>> +	case PS3_DEV_TYPE_STOR_FLASH:
>> +		match_id = PS3_MATCH_ID_STOR_FLASH;
>> +		break;
>> +
>> +	default:
>> +		return 0;
>> +	}
> 
> Why do you have separate constants for PS3_DEV_TYPE_* and
> PS3_MATCH_ID_*? If you don't do any conversion, this driver
> will immediately work for additional types as well, if more
> get added later.

I noticed we have some redundancy in the constants and such
now that we have unified the device support.  I planned to go
through and try to clean up what I can.

-Geoff
