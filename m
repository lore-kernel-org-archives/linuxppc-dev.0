Return-Path: <benh@kernel.crashing.org>
Subject: Re: Time for cell code reshuffle?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20071222151136.1198f96d@hansolo.jdub.homelinux.org>
References: <200712211522.03841.arnd@arndb.de>
	<476BF67C.2030405@am.sony.com> <1198357082.6686.5.camel@pasglop>
	<20071222151136.1198f96d@hansolo.jdub.homelinux.org>
Content-Type: text/plain
Date: Sun, 23 Dec 2007 08:21:30 +1100
Message-Id: <1198358490.6686.10.camel@pasglop>
Mime-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-12-22 at 15:11 -0600, Josh Boyer wrote:
> > 
> > No, platforms/xxx isn't supposed to be shared code. That's was
> syslib is
> > for.
> 
> I think you mean sysdev?

Yeah, whatever the name of the day for that thing is.

(It's syslib in arch/ppc ?)

Ben.
