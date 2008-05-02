Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C881DDFBF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 03:34:46 +1000 (EST)
In-Reply-To: <F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>
References: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
	<20080502150753.GA7753@ld0162-tx32.am.freescale.net>
	<F62A680D-C2D8-42B0-B4D6-F3A00F228EB1@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <03e9cbca081bff8f6db9862bf3d8d028@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
Date: Fri, 2 May 2008 19:34:23 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> <brokenrecord>
>> Why don't we just link with libgcc?
>> </brokenrecord>
>
> Its something of a PITA to do that in the kernel at this point since 
> we've duplicated libgcc functionality in it.  I'm sure there are some 
> historical reasons this wasn't done to start with.

That's the same as saying that it would be a nice cleanup to remove all
that duplicated code now...


Segher
