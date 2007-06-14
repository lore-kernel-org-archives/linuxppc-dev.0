Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <46713711.5010709@ru.mvista.com>
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>	<20070612044246.GC4198@localhost.localdomain>	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>	<20070613061254.GG16148@localhost.localdomain>	<bc98b5372977d171b0075074bfce7747@kernel.crashing.org>	<20070613091904.GA30948@localhost.localdomain>	<791ab8b82c5b5d2b3ae4827a891a43ea@kernel.crashing.org>
	<20070614042906.GC11177@localhost.localdomain>
	<46713711.5010709@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8f1fbce921069e16ce69806ed1370bfd@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Thu, 14 Jun 2007 15:20:24 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I tought I saw some config option implying that there already existed
>> an on-device partition table format for flashes.  Doesn't help us for
>
>    You probably mean RedBoot table?
>
>> existing boards which don't expect such a setup, of course.
>
>    Exactly. It's specific to RedBoot.

Sounds like we need to create a more generic format
then -- perhaps adopting most of the redboot thing.


Segher
