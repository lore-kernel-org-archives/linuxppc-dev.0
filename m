Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 563DF67B52
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 23:18:59 +1000 (EST)
In-Reply-To: <20060720072134.GX5219@scorpius.homelinux.org>
References: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
	<4856A73A-BB23-4850-A697-1CE7C385DE42@kernel.crashing.org>
	<1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
	<20060719201941.GW5219@scorpius.homelinux.org>
	<4AC92920-4642-4899-B8CA-8EE5A1CDE0B3@kernel.crashing.org>
	<20060720072134.GX5219@scorpius.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <10E25426-017C-495F-9586-E8A282084EAE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Thu, 20 Jul 2006 08:19:15 -0500
To: Marc Leeman <marc.leeman@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 2:21 AM, Marc Leeman wrote:

>>> Though I do agree that there is a gap: it would be nice to have some
>>> place to submit the kernel patches;
>>
>> This should be the kernel.  The general rule of thumb I've used is if
>> its useful to more than one other person its worth trying to get into
>> the kernel.  However, I can see if you are doing a one off kernel for
>
> That is about the same rule that I use; luckily (a credit to the Linux
> kernel and other developers); I don't have to change much stuff like
> that.
>
>> your embedded product that getting your changes into the kernel
>> wouldn't be worth while.  You have to have a desire to interact with
>> the community if you want to get your code in.
>
> There is a grey zone, but let's talk about a specific case:
>
> In my current queue, I have to write a Host Port Interface (HPI)  
> protocol
> (serial) to a TI DSP. I would imagine that this is a useful
> contribution. However, using HPI is almost by nature limited to  
> specific
> embedded designs (most of which differ slightly from one another).
> Furthermore; I will need to use a number of GPIO pins on a 834x
> processor. Using this needs to be backed by configuration settings in
> U-Boot. If someone else makes a similar design; it would most  
> likely be
> with another processor family; and even then; they'll have other pins
> connected/used.
>
> Though the protocol would be a real nice addition; the physical
> connection/configuration make including it in the main kernel tree
> difficult.

Maybe, but your are just talking about abstracting what GPIO pins are  
used, which is a minor issue.

>> Personally, I see it useful if for no other reason that someone will
>> fixup my board port if/when they change something which will make my
>> moving to a newer kernel release that much easier.
>
> Even though I would welcome this; our boards are included in larger
> expensive systems that would just be shipped back in case of problems;
> but we've never had functional (linux) problems (yet).
>
> Come to think of it, I have a number of minor patches for 8349SYS  
> based
> configurations; where can I find the last devel code (next to 2.6.17)
> for patch creation (and to whom to send them back)?

Grab a git kernel from kernel.org/git, I'd say to use either linux/ 
kernel/git/torvalds/linux-2.6.git (Linus's tree) or linux/kernel/git/ 
paulus/powerpc.git (Paul's tree).

You'd send the patches to me as I'm the maintainer for 83xx stuff.

- kumar
