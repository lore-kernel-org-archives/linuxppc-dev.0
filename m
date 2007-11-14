Return-Path: <imrek@atomki.hu>
Received: from imrek.org (strawberry.diszk.unideb.hu [193.6.143.139])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2AF9ADDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Nov 2007 04:42:20 +1100 (EST)
Date: Wed, 14 Nov 2007 18:00:23 +0100 (CET)
From: jozsef imrek <imrek@atomki.hu>
To: g.schardt@fz-juelich.de
Subject: Re: Virtex TEMAC 1000Mb/s trouble, but 100b/s is working
In-Reply-To: <32948332c393.32c393329483@fz-juelich.de>
Message-ID: <Pine.LNX.4.61.0711141749140.22375@imrek.org>
References: <32948332c393.32c393329483@fz-juelich.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

On Wed, 14 Nov 2007 g.schardt@fz-juelich.de wrote:

>>
>> Trouble solved by adding tcp,no_lock !!!
>>
>
> can you tell me, how to add this parameters to the kernel boot parameter ? or do you mount after booting ?
>

if you are using a bootloader see Documentation/nfsroot.txt in the linux
source tree (a quick example: nfsroot=192.168.0.1:/nfsroot,tcp,no_lock).

if you are using dhcp, then you have to tell your dhcp server to serv 
these paramters (for the isc dhcpd: option root-path "/nfsroot,tcp,no_lock").

-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       imrek@atomki.hu
----------------------------------------------------------------
