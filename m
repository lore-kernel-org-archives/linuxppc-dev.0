Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EF6BD2BDA2
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2004 12:18:48 +1000 (EST)
In-Reply-To: <4153A362.8010604@sonartech.com.au>
References: <4153A362.8010604@sonartech.com.au>
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 24 Sep 2004 10:01:58 -0500
To: David Gardiner <daveg@sonartech.com.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Not sure that this really belongs here but since I've got an i386 - 
> 2.6.7 running with a e1000 fine I would assume, it's got something to 
> do with the platform and I'm hoping someone has seen something 
> similar. Anyway whenever I configure a gigabit ethernet card (bcm5700 
> or intel pro 1000) the system hangs and 100 base (e100) is fine.

It's not the platform; I've run both e1000 and tg3 successfully
on PowerPC systems, no problems getting it to work at all.


Segher
