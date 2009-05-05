Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89A27DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 21:07:52 +1000 (EST)
Message-Id: <D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: MSR_SPE - being turned off...
Date: Tue, 5 May 2009 06:07:40 -0500
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2009, at 5:25 PM, Morrison, Tom wrote:

> I have both a MPC8548 SBC and MPC8572 system that are running =20
> different flavors of the
> same Linux =96 2.6.23.
>
> I explicitly am turning it on very early on. Later, I have an =20
> application that is compiled
> with SPE instructions (e.g.: evstdd) , and there is where the =20
> problems happen. If I explicitly
> make sure there are NO SPE instructions in the application, nothing =20=

> bad happens!
>
> I am polling the MSR =96 and it seems the SPE is turned OFF?
>
> What have I done wrong and/or has there been fixes in later kernels =20=

> that I should be aware of that might help this issue?

Can you explain what you mean by explicitly am turning it on very =20
early on.

I can't think of anything that has changed w/regards to SPE handling.

- k=
