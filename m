Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 38C96DDF49
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:09:23 +1100 (EST)
Message-ID: <4783BC52.30704@pikatech.com>
Date: Tue, 08 Jan 2008 13:09:22 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Hwmon for Taco
References: <477F1196.7000109@pikatech.com> <1199517763.7291.47.camel@pasglop>
	<47831868.3030309@pikatech.com>
	<fa686aa40801072259w63899e74y45d55bd5e9844b68@mail.gmail.com>
In-Reply-To: <fa686aa40801072259w63899e74y45d55bd5e9844b68@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> This is *very* board specific and not very complex a driver.  It
> should probably live with the platform code somewhere in
> arch/powerpc/platforms.  You can use the machine_device_initcall()
> hook to kick off the thread.
>   
Doh, this is why I post to this list. The platform code already had an 
obvious place to put this, so I moved it there.

I will cleanup the ad7414.c driver and repost the patch.

Cheers,
   Sean
