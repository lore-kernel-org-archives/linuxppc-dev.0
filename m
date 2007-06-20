Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id DB094DDE42
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 22:16:48 +1000 (EST)
In-Reply-To: <Pine.LNX.4.62.0706191405190.4069@pademelon.sonytel.be>
References: <d46c75da8a86ab5cd83b63f9dbfee33f@bga.com>
	<Pine.LNX.4.62.0706191405190.4069@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dcf4c6884c22627387c1ccf4a04158e3@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 5/6] ps3: ROM Storage Driver
Date: Wed, 20 Jun 2007 07:16:33 -0500
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 19, 2007, at 7:29 AM, Geert Uytterhoeven wrote:
> On Mon, 18 Jun 2007, Milton Miller wrote:
>>> +config PS3_ROM
>>> +	tristate "PS3 ROM Storage Driver"
>>> +	depends on PPC_PS3 && BLK_DEV_SR
>>> +	select PS3_STORAGE
>>> +	help
>>> +	  Include support for the PS3 ROM Storage.
>>> +
>>> +	  This support is required to access the PS3 BD/DVD/CD-ROM drive.
>>> +	  In general, all users will say Y or M.
>>> +
>>
>> Why does it depend on BLK_DEV_SR?
>
> Because it needs SCSI CD-ROM support.
>

To compile?  I don't see any exports there.

My point is if it only relies on it to produce the device node, then 
you should provide guidance in your help text but not make the module 
build dependent on it.

milton
