Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2ADEB474D6
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 08:50:12 +1100 (EST)
Message-Id: <7E6F9CA6-92CF-4EBE-9D18-925D2CD1BC8A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <20090107214834.GF11454@infomag.infomag.iguana.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] watchdog: Basic support for GE Fanuc's FPGA based
	watchdog timer
Date: Wed, 7 Jan 2009 15:50:03 -0600
References: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
	<20081110123125.8608.2251.stgit@ubuntu8041.localdomain>
	<A23D61BC-CA79-490C-8C70-F4341E7844EA@kernel.crashing.org>
	<20090107214834.GF11454@infomag.infomag.iguana.be>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Martyn Welch <martyn.welch@gefanuc.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2009, at 3:48 PM, Wim Van Sebroeck wrote:

> Hi All,
>
>> Any status of acceptance of this?
>
> I changed the ioctl to an unlocked ioctl and removed the temperature  
> ioctl call.
> It's now in my linux-2.6-watchdog-next tree. Can someone verify that  
> it still works?
> (http://git.kernel.org/?p=linux/kernel/git/wim/linux-2.6-watchdog-next.git;a=summary 
> )
>
> Kumar,
>
> the second patch is also in. Do we keep in in the watchdog tree  
> since it almost doesn't
> touch the powerpc arch or do you want it in your tree?

If you have it in your tree to pull go ahead and send it via  
watchdog.  (I assume this will be for 2.6.29)

- k
