Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0473810089B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Nov 2009 09:49:22 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 00/19] powerpc: nintendo gamecube and wii support
Date: Sun, 22 Nov 2009 23:49:15 +0100
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911222349.15290.arnd@arndb.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 22 November 2009, Albert Herranz wrote:
> The following patches add the base support for the Nintendo GameCube
> and Wii video game consoles on the powerpc arch.
> 
> For each video game console, the following is included:
> - a device tree source
> - bootwrapper support
> - udbg console option
> - early udbg console option
> - interrupt controller support
> - platform support
> 
> The Nintendo Wii patches also include support for:
> - recognition of the broadway processor
> - ipc communication with the open source 'mini' firmware replacement
> 
> With these patches both video game consoles can fully boot up to the
> root filesystem mount phase.

Very nice series, well done!

Time for me to invest in some new hardware ;-)

	Arnd <><
