Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 3595DDDED2
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 03:14:18 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Paul Collins <paul@burly.ondioline.org>
Subject: Re: Badness at kernel/time/timekeeping.c:98 in pmud
	(timekeeping_suspended)
Date: Wed, 21 Jan 2009 17:13:39 +0100
References: <87prihcepl.fsf@burly.wgtn.ondioline.org>
In-Reply-To: <87prihcepl.fsf@burly.wgtn.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901211713.39630.rjw@sisk.pl>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 January 2009, Paul Collins wrote:
> Got a couple of these on a PowerBook running 2.6.29-rc2 either during
> suspend or resume -- it's hard to tell.  (The suspend message is
> timestamped in syslog with the time I resumed, so I guess it was
> buffered along with the subsequent "Badness" messages.)

Please check if the patch from http://lkml.org/lkml/2009/1/13/144 fixes the
problem for you.

Thanks,
Rafael
