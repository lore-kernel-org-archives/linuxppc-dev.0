Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 3BEEBB70AB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 23 Aug 2010 18:53:17 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH/v2] via-pmu: add compat_pmu_ioctl
Date: Mon, 23 Aug 2010 10:53:07 +0200
References: <m2lj7zzm6w.fsf@igel.home> <201008221333.50575.arnd@arndb.de>
	<m2hbimmxai.fsf_-_@igel.home>
In-Reply-To: <m2hbimmxai.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008231053.07836.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sunday 22 August 2010, Andreas Schwab wrote:
> The ioctls are actually compatible, but due to historical mistake the
> numbers differ between 32bit and 64bit.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
