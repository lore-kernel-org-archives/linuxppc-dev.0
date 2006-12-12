Return-Path: <root@ucw.cz>
Received: from spitz.ucw.cz (gprs189-60.eurotel.cz [160.218.189.60])
	by ozlabs.org (Postfix) with ESMTP id D946767C3B
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Dec 2006 01:40:50 +1100 (EST)
Date: Tue, 12 Dec 2006 13:10:01 +0000
From: Pavel Machek <pavel@suse.cz>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 2/3] windfarm: dont die on suspend thread signal
Message-ID: <20061212131000.GC5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net>>
	<20061211230754.679589000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061211230754.679589000@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, Torrance <torrance123@gmail.com>,
	Michael Buesch <mb@bu3sch.de>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue 12-12-06 00:02:10, Johannes Berg wrote:
> When the windfarm thread gets a suspend signal it will die instead of
> freezing. This fixes it.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

ACK.

-- 
Thanks for all the (sleeping) penguins.
