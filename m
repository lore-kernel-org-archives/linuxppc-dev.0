Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A45C2DE1DD
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 09:15:23 +1000 (EST)
In-Reply-To: <20090409224553.GO16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<7ED93BB3-FE0E-4102-89FB-78950A533717@kernel.crashing.org>
	<20090409224553.GO16602@bilbo.ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A514ABE0-300C-4201-BF6B-C0BF465D61A2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Date: Fri, 10 Apr 2009 01:18:35 +0200
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> -Wno-unused or -Wno-unused-pparameter and/or -Wno-unused- 
>> variable.  But I
>> thought this was about uninitialised var warnings?  -Wno- 
>> uninitialized
>> for that one.
>
>> If you are asking for a GCC option that will warn for all suspect  
>> cases
>> _except_ for the ones where it is obvious to you there is no problem:
>> you could try -Wesp.
>
> Ooops I was asking for -Wno-uninitialized.  I'll try a build with:
> 	-Wno-uninitialized -Wesp
> and see how that goes.

-Wesp was a joke: I was trying to say that the compiler cannot read  
minds.
It doesn't know what potentially unused variables are obviously (to you)
actually used.


Segher
