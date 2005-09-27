Return-Path: <dostrow@gentoo.org>
From: Daniel Ostrow <dostrow@gentoo.org>
To: Christopher Friesen <cfriesen@nortel.com>
In-Reply-To: <433976BA.6010206@nortel.com>
References: <1127835826.7811.27.camel@Memoria.anyarch.net>
	<433976BA.6010206@nortel.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 13:29:43 -0400
Message-Id: <1127842184.7811.61.camel@Memoria.anyarch.net>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
Reply-To: dostrow@gentoo.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-09-27 at 10:43 -0600, Christopher Friesen wrote:
> Daniel Ostrow wrote:
> > Anything in
> > the 6.8.2 range (which is what is stable) has been working fine for a
> > long long time under a pure 64-bit env.
> 
> What about mixed 32-bit userspace and 64-bit kernel?
> 
> Chris
> 

The way I set that up is still young...and has some issues (most of
which should be fixed by the ppc && ppc64 -> powerpc merge). From what I
have tested, it does work perfectly fine with 6.8.2...I haven't run into
any issues. I maintain that profile so if there are issues please take
them off this list...feel free to send them to ppc64@gentoo.org or open
a bug at bugs.gentoo.org and assign it to the ppc64 group. I'll see it
either way.

Thanks,

-- 
Daniel Ostrow
Gentoo Foundation Board of Trustees
Gentoo/{PPC,PPC64,DevRel}
dostrow@gentoo.org
