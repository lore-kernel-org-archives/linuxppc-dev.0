Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A92F0DDFB6
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 03:54:56 +1000 (EST)
Message-ID: <470A6E4E.5090009@am.sony.com>
Date: Mon, 08 Oct 2007 10:52:14 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ranulf Doswell <ralf@ranulf.net>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
References: <20071006213542.311447584@am.sony.com>	
	<20071006213542.954029915@am.sony.com>
	<18a15270710080648x3b5f1135meea3d7b048a1a543@mail.gmail.com>
In-Reply-To: <18a15270710080648x3b5f1135meea3d7b048a1a543@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ranulf Doswell wrote:
> On 06/10/2007, *geoffrey.levand@am.sony.com
> <mailto:geoffrey.levand@am.sony.com>* <geoffrey.levand@am.sony.com
> <mailto:geoffrey.levand@am.sony.com>> wrote:
> 
>> enum os_area_db_owner {
> 
>> 	OS_AREA_DB_OWNER_ANY = -1,
>> 	OS_AREA_DB_OWNER_NONE = 0,
>>	OS_AREA_DB_OWNER_PROTOTYPE = 1,
>>	OS_AREA_DB_OWNER_LINUX = 2,
> 
>>	OS_AREA_DB_OWNER_PETITBOOT = 3,
>>	OS_AREA_DB_OWNER_MAX = 32,
>>};
>>
>>enum os_area_db_key {
>>	OS_AREA_DB_KEY_ANY = -1,
>>	OS_AREA_DB_KEY_NONE = 0,
>>	OS_AREA_DB_KEY_RTC_DIFF = 1,
> 
>>	OS_AREA_DB_KEY_VIDEO_MODE = 2,
>>	OS_AREA_DB_KEY_MAX = 8,
>>};
> 
> How do we go about claiming one of these OS_AREA_DB_OWNER_ keys? I'd
> very much like to use this functionality in my python-ps3 games library.


It sounds like you should be storing your info in the file system like
all other applications do.
