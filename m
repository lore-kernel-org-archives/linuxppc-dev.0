Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E83BDDDE2E
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 08:24:49 +1000 (EST)
Message-ID: <463E55CA.3040204@genesi-usa.com>
Date: Sun, 06 May 2007 23:25:14 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: spitzauer_77@gmx.de
Subject: Re: Writing an AC97 device driver for MPC52xx
References: <20070503142259.222640@gmx.net>
In-Reply-To: <20070503142259.222640@gmx.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a driver available for the Efika and Lite5200B boards.

It needs a lot of improvement but it's there. I can send you a copy of the
patch for the AC97 if you like, seperate to the list. No point duplicating
work. I'm sure others can do the same if they have anything else (although
the driver will no doubt be Sylvain's :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

spitzauer_77@gmx.de wrote:
> Hi all,
> 
> i try to write device driver for an AC97 external codec on MPC5200 controller. The PSC1 and 2 on MPC5200 can be configured as AC97.
> 
> I'm a little bit new in this topic of writing linux drivers and read a lot in the internet about this. (e.g. http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x1052.htm )
> 
> But i have some questions:
> 
> - Is there a simple driver maybe on other platforms available, which have the same problem solved?? Most of the sound drivers are coupled with pci.
> 
> - I only have to write the pure hardware (PSC) stuff, or?? I'm little confused on how i should handle this with AC97 (ac97_codec.c) and ALSA.
> 
> - Is this for my driver the correct layer:
>   User App -> ALSA -> AC97 -> "My driver" -> Hardware MPC52xx
> 
> 
> I'm glad for any hint!
> 
> Spitzauer
