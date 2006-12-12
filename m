Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id 6DB7367C32
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 00:22:49 +1100 (EST)
Date: Tue, 12 Dec 2006 13:22:41 +0000
From: Pavel Machek <pavel@suse.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 0/3] experimental G5 powermac suspend
	implementation
Message-ID: <20061212132240.GE5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net>>
	<1165926068.22338.15.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165926068.22338.15.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org,
	Michael Buesch <mb@bu3sch.de>, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue 12-12-06 13:21:07, Johannes Berg wrote:
> Date/time is restored to wherever it was when suspending. Does anyone
> know how to fix that? Does the RTC somehow warp the time on resume or do
> we somehow mark the time/date __nosave?

Clock do not tick while suspended; I guess you need to copy time
suspend/resume from i386 or something.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
