Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 65C92474D6
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 02:32:55 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: "Gunnar Von Boehn" <gunnar@genesi-usa.com>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Thu, 4 Sep 2008 18:32:29 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<200809041459.27606.david.jander@protonic.nl>
	<b989d750809040801x50019cf9j9741219348c9b5f7@mail.gmail.com>
In-Reply-To: <b989d750809040801x50019cf9j9741219348c9b5f7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809041832.29931.david.jander@protonic.nl>
Cc: munroesj@us.ibm.com, John Rigby <jrigby@freescale.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	prodyut hazarika <prodyuth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 04 September 2008 17:01:21 Gunnar Von Boehn wrote:
>[...]
> Regarding the 5121.
> David, you did create a very special memcopy for the 5121e CPU.
> Your test showed us that the normal glibc memcopy is about 10 times
> slower than expected on the 5121.
>
> I really wonder why this is the case.
> I would have expected the 5121 to perform just like the 5200B.
> What we saw is that switching from READ to WRITE and back is very
> costly on 5121.
>
> There seems to be a huge difference between the 5200 and its successor the
> 5121. Is this performance difference caused by the CPU or by the board
> /memory?

I have some new insight now, and I will look more closely at the working of  
the DRAM controller... there has to be something wrong somewhere, an I am 
going to find it... whether it is some strange bug in my u-boot code 
(initializing the DRAM controller and prio-manager for example) or a 
silicon-errata (John?)

Thanks a lot for your help so far.

-- 
David Jander
