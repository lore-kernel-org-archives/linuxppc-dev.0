Return-Path: <dgibson@ozlabs.org>
Date: Thu, 5 Jun 2008 21:00:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Message-ID: <20080605110031.GC30980@yookeroo.seuss>
References: <1212130188-28835-2-git-send-email-wg@grandegger.com>
	<20080602020352.GB19393@yookeroo.seuss>
	<479BA7CE-CD12-4935-87EB-E69025D408E6@kernel.crashing.org>
	<4845181E.8040603@grandegger.com>
	<07AEED44-7DEB-46C1-B028-3EFA274CEB11@kernel.crashing.org>
	<20080603223905.GA22982@yookeroo.seuss>
	<484663DB.5000905@grandegger.com>
	<02EC7209-F395-4C01-A445-E111E6E54A25@kernel.crashing.org>
	<48478B1C.9040300@grandegger.com>
	<EC50D666-4E20-462B-880F-502E61A76EFA@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EC50D666-4E20-462B-880F-502E61A76EFA@kernel.crashing.org>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 02:43:59AM -0500, Kumar Gala wrote:
>>>>>
>>>> I'm puzzled. Could someone point me to some real code where cell- 
>>>> index
>>>> is used as a pointer into some global data. Sorry for my ignorance.
>>>
>>> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html
>>
>> Yep, I saw that it's used for I2C (and SPI). But "cell-index" is also
>> defined for network, serial and PCI nodes, which are also assigned via
>> aliases.
>
> Some of this is for the future.  There are other SoC registers (like on 
> 85xx in GUTS) that need index information.

Likewise for 4xx (where the 'cell-index' notation originated), the
index value is the number used throughout the user manual and
(thereby) in power control registers and the like.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
