Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Michael Guntsche <mike@it-loops.com>
Subject: Re: Build failure on PPC32 due to 60adec6226bbcf0
In-reply-to: <20100526073017.GA24005@gibson.comsick.at>
References: <20100526073017.GA24005@gibson.comsick.at>
Date: Thu, 27 May 2010 07:00:50 +1000
Message-ID: <7385.1274907650@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I recently started a test build of the current git tree for one of my
> PPC machines. I got a build error about crash_kexec_wait_realmode
> being implicitly declared. Looking at the changes I saw that your
> "powerpc/kdump: Fix race in kdump shutdown" patch introduced this
> function but only if CONFIG_SMP is defined. This is not the case in my
> config (single CPU).

Yep, this is known.  Kumar is going to clean it up soon.  

http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-May/082631.html

Mikey
