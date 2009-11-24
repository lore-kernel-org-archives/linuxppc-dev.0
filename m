Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 5DDD0B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 09:33:36 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 06/19] powerpc: gamecube/wii: introduce GAMECUBE_COMMON
Date: Tue, 24 Nov 2009 23:33:27 +0100
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<4B0C2002.4050704@yahoo.es>
	<7129FD29-82CE-4731-90F2-0EA6775EF861@kernel.crashing.org>
In-Reply-To: <7129FD29-82CE-4731-90F2-0EA6775EF861@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911242333.27485.arnd@arndb.de>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 24 November 2009, Segher Boessenkool wrote:
> > This option should be used only for options applicable to both the  
> > GAMECUBE and WII, i.e. basically those options in the WII which  
> > where "inherited" from the GAMECUBE to make it retro-compatible.
> >
> > If GAMECUBE_COMMON is unacceptable, maybe GAMECUBE_LEGACY or  
> > GAMECUBE_COMPAT?
> 
> Maybe it's best to write GAMECUBE || WII in the places that use it,  
> then?

Or just use CONFIG_NINTENDO? If we ever want to port to a future
Nintendo system that is not compatible, we can still change it.

	Arnd <><
