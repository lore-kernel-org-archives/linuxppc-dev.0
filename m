Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AC945DDFA4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:50:35 +1000 (EST)
Message-ID: <470AB435.6040403@am.sony.com>
Date: Mon, 08 Oct 2007 15:50:29 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Ranulf Doswell <ralf@ranulf.net>
Subject: Re: [patch 2/6] PS3: Remove unused os-area params
References: <20071006213542.311447584@am.sony.com>	
	<20071006213542.595771597@am.sony.com>	
	<18a15270710080700m514b49f6p7dc9cf6c8f80d6a6@mail.gmail.com>	
	<470A6E9C.50904@am.sony.com>
	<18a15270710081538j85cc680w3815baa80f050ad4@mail.gmail.com>
In-Reply-To: <18a15270710081538j85cc680w3815baa80f050ad4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ranulf Doswell wrote:
> On 08/10/2007, *Geoff Levand* <geoffrey.levand@am.sony.com
> <mailto:geoffrey.levand@am.sony.com>> wrote:
> 
>     Ranulf Doswell wrote:
>     >
>     > As these values are correctly populated by the hypervisor from the
>     > preferences on the standard PS3 OS, it is incredibly useful to
>     have this
>     > information available.
> 
>     No, it is not used, and I never used it.
> 
> 
> Maybe I've mistaken how these are used. Having just looked at the source
> again, I see that the saved_params field isn't exported.
> 
> Am I correct in assuming that this information will still be available
> in /dev/ps3flash starting at offset 0x200? That's actually where I'm
> expecting to find the information anyway. I believed your patch was
> changing that behaviour, although I probably didn't study it enough.

Yes, and you can use libps3-utils to get it:

  http://git.kernel.org/?p=linux/kernel/git/geoff/ps3-utils.git

-Geoff
