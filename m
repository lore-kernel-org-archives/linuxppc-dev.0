Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7463DDF1A
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 23:13:29 +1000 (EST)
In-Reply-To: <468FDB8F.4050007@ru.mvista.com>
References: <1179245829.8132.100.camel@rhino>
	<1179246470.8132.112.camel@rhino>	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<468FDB8F.4050007@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3D4AB802-A3D2-46CC-9BD1-1064EE0AC84C@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Sun, 8 Jul 2007 15:13:06 +0200
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

>>>> +				8042@60 {
>>>> +					device_type = "8042";
>
>> Drop the device_type.  A number as a name isn't
>> all that great, either.
>
>   Yet it's kinda accepted years ago, see:
>
> http://playground.sun.com/1275/proposals/Closed/Accepted/381-it.txt

That's not a published recommendation or anything like that.


Segher
