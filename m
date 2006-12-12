Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 6391567C5C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 04:34:28 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 12 Dec 2006 18:34:21 +0100
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [linux-pm] [RFC 0/3] experimental G5 powermac suspend
	implementation
Message-ID: <20061212173421.GA31090@iram.es>
References: <20061211230208.526233000@sipsolutions.net>
	<1165926068.22338.15.camel@johannes.berg>
	<20061212132240.GE5190@ucw.cz>
	<1165930563.22338.32.camel@johannes.berg>
	<1165932463.22338.37.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165932463.22338.37.camel@johannes.berg>
Cc: linuxppc-dev@ozlabs.org, Pavel Machek <pavel@suse.cz>,
	linux-pm@lists.osdl.org, Michael Buesch <mb@bu3sch.de>,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 12, 2006 at 03:07:43PM +0100, Johannes Berg wrote:
> On Tue, 2006-12-12 at 14:36 +0100, Johannes Berg wrote:
> 
> > Well the RTC of course ticks but the system clock obviously doesn't.
> > Yes, I'll have to look at the time suspend/resume code. Do you know
> > where to find it?
> 
> Never mind, found it easily enough: it's in arch/i386/kernel/time.c

Timer is also restored from RTC on wakeup on powerbooks, so 
there is already something under arch/powerpc...

	Gabriel
