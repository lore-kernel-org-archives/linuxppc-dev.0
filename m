Return-Path: <j.glisse@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.200])
	by ozlabs.org (Postfix) with ESMTP id 52EA467B54
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 08:27:52 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so1241854wra
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Apr 2005 15:27:51 -0700 (PDT)
Message-ID: <4240b916050408152737ee7286@mail.gmail.com>
Date: Fri, 8 Apr 2005 23:27:50 +0100
From: Jerome Glisse <j.glisse@gmail.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050408153407.GZ3396@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4240b916050404033230db0551@mail.gmail.com>
	<20050407171026.GO3396@smtp.west.cox.net>
	<4240b91605040803137e9e7ddc@mail.gmail.com>
	<20050408153407.GZ3396@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.12-rc2] ppc32: Fix building 32bit kernel for 64bit
	machines (Was: Re: linux 2.6.12-rc1-bk5 compilation error)
Reply-To: Jerome Glisse <j.glisse@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> OK, I think the following is a better workaround for that (based on
> arch/ppc/platforms/pmac_sleep.S):
> 
> When building a ppc32 MULTIPLATFORM kernel for a 64bit pmac, we try and
> build certain files or use certain functions that make no sense in that
> context.  This catches the last of these.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

Works fine over here. Thx.

Jerome Glisse
