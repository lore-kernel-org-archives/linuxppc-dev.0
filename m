Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 130CADEC52
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 06:50:22 +1000 (EST)
In-Reply-To: <4E62E532-1E3D-4109-B6C4-152F39567CA8@kernel.crashing.org>
References: <1212180199-968-1-git-send-email-galak@kernel.crashing.org>
	<701fe7d26b27ceaffae6e3b77bf94cf7@kernel.crashing.org>
	<4E62E532-1E3D-4109-B6C4-152F39567CA8@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7c624bb773b7c8df8357a3b151e2d9fa@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Cleanup mpic nodes in .dts
Date: Mon, 2 Jun 2008 18:32:18 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Removed clock-frequency and big-endian props as they aren't specified
>>> anywhere.
>>
>> If you remove "big-endian", you'll have to provide some other way
>> to get that information (like, some new "compatible" value).
>
> I'm all for "big-endian" but we don't spec this anywhere and aren't 
> using it right now.  So until we have an real need to start an 
> extended mpic definition I'm getting rid of it.

If we would remove everything insufficiently documented, not much would
be left.  This doesn't seem very productive to me.  Could you instead
just add some TODO somewhere?

>> Dunno if we need "clock-frequency".
>
> Not used today.

Sure, the kernel might not use it today, but that's no reason to remove
stuff from the device tree.

I'm not against removing "clock-frequency" though, it's not 
well-defined,
and what would it be useful for anyway?

>> This patch also removes "built-in" properties.  I'm all for that,
>> but the patch description didn't say it does.
>>
> will add that to the commit message.

Thanks.


Segher
