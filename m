Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200605020150.14152.arnd@arndb.de>
References: <20060429232812.825714000@localhost.localdomain>
	<F989FA67-91B5-493B-9A12-D02C3C14A984@kernel.crashing.org>
	<445690F7.5050605@am.sony.com> <200605020150.14152.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Tue, 2 May 2006 02:06:10 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  config SPIDER_NET
>>  	tristate "Spider Gigabit Ethernet driver"
>> -	depends on PCI && PPC_CELL
>> +	depends on PCI && PPC_IBM_CELL_BLADE
>>  	select FW_LOADER
>>  	help
>>  	  This driver supports the Gigabit Ethernet chips present on the
>
> Hmm, I'm also no longer sure if this is right. In theory, spidernet
> could be used in all sorts of products, wether they are using the
> same bridge chip or just the gigabit ethernet macro from it.
>
> For now, I guess you can just leave this one alone if you respin
> the patch another time. It's disabled by default, so the dependency
> can be updated the next time we get a user in _addition_ to PPC_CELL.

Is there any reason the driver wouldn't build and/or run on other
platforms?  If so, fix it.  If not, just make it

	depends on PCI

?


Segher
