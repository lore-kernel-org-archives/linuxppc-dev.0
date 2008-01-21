Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2135BDDED1
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 04:50:36 +1100 (EST)
Message-ID: <4794DB6A.1010204@pikatech.com>
Date: Mon, 21 Jan 2008 12:50:34 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Warp Watchdog
References: <478FB93A.7040505@pikatech.com>
	<20080121080157.0b66c7fc@zod.rchland.ibm.com>
In-Reply-To: <20080121080157.0b66c7fc@zod.rchland.ibm.com>
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

Josh Boyer wrote:
> I'm not thrilled with it being in the platform file itself.  It should
> really go into drivers/watchdog.  It's OK that the watchdog is tied to
> Warp, that really isn't an issue.  Just make it depend on Warp in the
> Kconfig file.  And you can select it in your board config so that it's
> built in-kernel and not as a module.
>
> The code itself looks pretty clean.
>   
Thanks for the feedback. I think I was trying to convince myself that 
the platform was a good place but honestly felt it should be in the 
drivers/watchdog. So I moved it there.

Cheers,
   Sean
