Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <200605021259.24157.arnd@arndb.de>
References: <20060429232812.825714000@localhost.localdomain>
	<200605020150.14152.arnd@arndb.de>
	<1900A234-BE31-4292-87E1-5C02F12A440D@kernel.crashing.org>
	<200605021259.24157.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <801072F8-7701-4BD7-81FB-A8C1AA534C2E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 11/13] cell: split out board specific files
Date: Wed, 3 May 2006 01:38:56 +0200
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

>> Is there any reason the driver wouldn't build and/or run on other
>> platforms?  If so, fix it.  If not, just make it
>>
>>         depends on PCI
>
> Well, it could run on other platforms, except:
>
> - it requires a few properties in the device tree (local-mac-address,
>   firmware), so it should also depend on PPC

The portions of code that require OF should have appropriate #ifdef  
guards.

> - It's not actually PCI at all, but on an internal bus that has
>   something close enough to a PCI config space.

Our emulation should be good enough; if not, holler (off-list).


Segher
