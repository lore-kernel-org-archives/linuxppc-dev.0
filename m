Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] Time for cell code reshuffle?
Date: Sun, 23 Dec 2007 12:47:42 +0900
References: <200712211522.03841.arnd@arndb.de>
In-Reply-To: <200712211522.03841.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712231247.44154.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

> To the question, where what it should go, I'd leave the decision to
> Jeremy, but my current idea would be:
>
> arch/powerpc/platforms/cell/spufs -> arch/powerpc/spufs

I'd suggest arch/powerpc/sysdev/spufs to keep arch/powerpc clean.

However, this may also depend on the (intended) structure of SPURSEngine 
support, which may mean that fs/spufs might be a better place. It would 
suck to have to move things twice, so maybe someone from Tosihba could 
provide some input? Would the powerpc spufs code be suitable for 
SPURSEngine?

As thers have posted earlier, i gthink that arch/powerpc/sysdev/cell 
would be good for the generic cell support, then we could have 
arch/powerpc/platforms/{cell,ps3,beat} containing only the individual 
platform code.

Cheers,


Jeremy
