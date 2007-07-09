Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE6F6DDEE6
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 00:43:53 +1000 (EST)
In-Reply-To: <46922D86.5040305@ru.mvista.com>
References: <1179245829.8132.100.camel@rhino>
	<1179246470.8132.112.camel@rhino>	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<468FDB8F.4050007@ru.mvista.com>
	<3D4AB802-A3D2-46CC-9BD1-1064EE0AC84C@kernel.crashing.org>
	<46922D86.5040305@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5816A150-CF82-4608-B175-C70183D2662D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Mon, 9 Jul 2007 16:43:17 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>   Yet it's kinda accepted years ago, see:
>
>>> http://playground.sun.com/1275/proposals/Closed/Accepted/381-it.txt
>
>> That's not a published recommendation or anything like that.
>
>    There's also this document with a status of "unapproved draft":
>
> http://playground.sun.com/1275/bindings/devices/html/8042.html
>
>    So, all this never got final approval? Somewhat confusing (well,  
> what one could expect from OF? :-)

I think this 8042 thing became part of the CHRP binding.  There
never was a (published) x86 binding btw.  So for our current
purposes (flat device tree) I recommend we just do the minimal
sane thing, i.e., no device_type and some good "compatible" entry.


Segher
