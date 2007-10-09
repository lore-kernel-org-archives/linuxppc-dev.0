Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail59-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C7034DE039
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 11:12:33 +1000 (EST)
Message-ID: <470AD578.2060406@am.sony.com>
Date: Mon, 08 Oct 2007 18:12:24 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
	<Pine.LNX.4.62.0710081412260.31455@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0710081412260.31455@pademelon.sonytel.be>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Sat, 6 Oct 2007 geoffrey.levand@am.sony.com wrote:
>> --- a/arch/powerpc/platforms/ps3/os-area.c
>> +++ b/arch/powerpc/platforms/ps3/os-area.c
> 
>> +static int db_get_video_mode(const struct os_area_db *db,
>> +	unsigned int *video_mode)
>         ^^^^^^^^^^^^^^
>> +{
>> +	return db_get_64(db, &os_area_db_id_video_mode, (uint64_t*)video_mode);
>                                                         ^^^^^^^^^^^
>> +}
> 
> Woops, memory corruption, when writing a 64-bit value to a 32-bit variable.

Whoa!  That routines is not even used, so I removed it.

-Geoff  
