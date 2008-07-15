Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7E3BDDFB3
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 22:52:52 +1000 (EST)
Message-Id: <6EB5960B-C8EC-4404-9F64-E241ED1A909F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1216101729.7740.84.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: powerpc.git merge status
Date: Tue, 15 Jul 2008 07:52:44 -0500
References: <1216101729.7740.84.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 15, 2008, at 1:02 AM, Benjamin Herrenschmidt wrote:

> I've pulled from Kumar, Josh and Grant, along with applying some
> patches hand picked from patchworks and build fixes. I've merged in
> Linus as of today (minus David Woodhouse firmware patches that have a
> build breakage) in order to fix a (fairly trivial) merge conflict.
>
> I've now pushed that to my powerpc.git "master" branch for overnight
> build-testing with kisskb at which point
>
> If all goes well, I'll put all of that in "merge" and "next" and ask
> Linus to pull it tomorrow.
>
> Now, regarding the remaining bits, still on my todo for the next  
> batch,
> probably later this week, in this merge window:
>
> 	- The CMO stuff, I need to have a closer look but it should
>          probably go in
> 	- Milton's serie. Mostly fixes, haven't had time to look too
>          closely yet.
> 	- Kumar PTE bits... that's a bit "hot" for this merge window
>          but I suppose it can still make it.
> 	- Some Cell stuff for which I'm waiting a new serie from Arnd
>
> If you believe I've missed something, now is time to be vocal about
> it :-)

There are a number of patches I still need to pick up but I expect  
this to be a second round of pulling.

- k
