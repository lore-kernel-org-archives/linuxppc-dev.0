Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32262DE0B6
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 09:07:09 +1100 (EST)
In-Reply-To: <20080310191957.0B42626F991@magilla.localdomain>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de>
	<1205110432.10078.5.camel@gargoyle>
	<200803101501.34439.jens@de.ibm.com>
	<20080310191957.0B42626F991@magilla.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <54cef72c35bbf5dd2d8eec5eec52f99e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Mon, 10 Mar 2008 23:06:40 +0100
To: Roland McGrath <roland@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Jan Kratochvil <jan.kratochvil@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> On the Blade DABRX had to be set additional to DABR. PS3 and Celleb
>> already did this. Uli Weigand found this back in November. I submitted
>> a patch for this which went into 2.6.25-rc4.
>> Can you please try again with rc4 ?
>
> This is not the problem.  This came up before and everyone seems have
> forgotten.  This bug has been reproduced on G5's, which do not have 
> DABRX
> as I understand it.

970 (all versions) _does_ have a DABRX register.  Dunno if it has
the same register definition (I cannot find DABRX in the Cell docs).


Segher
