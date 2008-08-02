Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 61AD3DDE0D
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Aug 2008 03:14:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Compact flash on mpc8349eITX
Date: Sat, 2 Aug 2008 19:13:56 +0200
References: <6011A7C9CD0EE74792C3ED2A835560863421AB@mail.twacs.com>
In-Reply-To: <6011A7C9CD0EE74792C3ED2A835560863421AB@mail.twacs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808021913.56838.arnd@arndb.de>
Cc: "Sparks, Sam" <SSparks@aclaratech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 01 August 2008, Sparks, Sam wrote:
> Has anyone successfully communicated with a compact flash device in true
> IDE mode on the MPC8349eITX? If so, do you happen to know the kernel
> configuration and/or revision?
> 

There are some CF cards and some IDE-CF adapters that are missing the lines
for DMA mode, even if the controller on the card supports DMA.
If a specific card doesn't work, try using a different one, or use PIO mode
only.

	Arnd <><
