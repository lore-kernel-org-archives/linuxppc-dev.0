Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E129DDF0A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 02:19:25 +1000 (EST)
Message-Id: <4E62E532-1E3D-4109-B6C4-152F39567CA8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <701fe7d26b27ceaffae6e3b77bf94cf7@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] [POWERPC] Cleanup mpic nodes in .dts
Date: Mon, 2 Jun 2008 11:19:14 -0500
References: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
	<701fe7d26b27ceaffae6e3b77bf94cf7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 30, 2008, at 4:42 PM, Segher Boessenkool wrote:

>> Removed clock-frequency and big-endian props as they aren't specified
>> anywhere.
>
> If you remove "big-endian", you'll have to provide some other way
> to get that information (like, some new "compatible" value).

I'm all for "big-endian" but we don't spec this anywhere and aren't  
using it right now.  So until we have an real need to start an  
extended mpic definition I'm getting rid of it.

> Dunno if we need "clock-frequency".

Not used today.

> This patch also removes "built-in" properties.  I'm all for that,
> but the patch description didn't say it does.
>
will add that to the commit message.

- k
