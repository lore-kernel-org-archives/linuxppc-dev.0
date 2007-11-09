Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CF499DDD0A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 08:12:52 +1100 (EST)
Subject: Re: Appletouch going wild
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je640ba837.fsf@sykes.suse.de>
References: <je640ba837.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sat, 10 Nov 2007 08:12:43 +1100
Message-Id: <1194642763.21340.22.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-11-09 at 13:58 +0100, Andreas Schwab wrote:
> Every once in a while the touchpad in my iBook G4 (geyser1, 030B) is
> going wild, emitting random movement events even when not being touched.
> That started only with 2.6.24-rc1.  The only way to stop it is to reload
> the appletouch module.  My guess would be that reinitializing the
> touchpad can result in some kind of race condition.

I always had that problem if I do something like leaving my finger too
long on it...

Ben.
