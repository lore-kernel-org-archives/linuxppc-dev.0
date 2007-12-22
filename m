Return-Path: <benh@kernel.crashing.org>
Subject: Re: Time for cell code reshuffle?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200712211522.03841.arnd@arndb.de>
References: <200712211522.03841.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 23 Dec 2007 07:57:32 +1100
Message-Id: <1198357052.6686.3.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> A related question is what to do about the location of the other cell
> related files. platforms/ps3 is already pretty self-contained once we have
> spufs outside of platforms/cell, but there is still some code shared between
> platforms/cell and platforms/celleb, and each of these directories also contains
> code that is only relevant for a subset of the platforms.
> 
> My position on these files is that while I find the current state a little
> bit confusing, I don't have an idea how to do it better either, and I think
> we should just leave the platform files where they are.

Some of these files could do to syslib, like the io workarounds, rename
them spider-io-hacks :-)

Ben.
