Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: dostrow@gentoo.org
In-Reply-To: <1127842184.7811.61.camel@Memoria.anyarch.net>
References: <1127835826.7811.27.camel@Memoria.anyarch.net>
	<433976BA.6010206@nortel.com>
	<1127842184.7811.61.camel@Memoria.anyarch.net>
Content-Type: text/plain
Date: Wed, 28 Sep 2005 10:07:08 +1000
Message-Id: <1127866028.6102.2.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Christopher Friesen <cfriesen@nortel.com>,
	linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The way I set that up is still young...and has some issues (most of
> which should be fixed by the ppc && ppc64 -> powerpc merge). From what I
> have tested, it does work perfectly fine with 6.8.2...I haven't run into
> any issues. I maintain that profile so if there are issues please take
> them off this list...feel free to send them to ppc64@gentoo.org or open
> a bug at bugs.gentoo.org and assign it to the ppc64 group. I'll see it
> either way.

I'm running a 32 bits X.org 6.8.99 from CVS with the r300 DRI stuff
etc... on a G5 with 64 bits kernel without trouble. Paulus did the same
with a 64 bits X.

Ben.
