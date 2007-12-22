Return-Path: <benh@kernel.crashing.org>
Subject: Re: Time for cell code reshuffle?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <476BF67C.2030405@am.sony.com>
References: <200712211522.03841.arnd@arndb.de> <476BF67C.2030405@am.sony.com>
Content-Type: text/plain
Date: Sun, 23 Dec 2007 07:58:02 +1100
Message-Id: <1198357082.6686.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	Jeremy Kerr <jk@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-12-21 at 09:23 -0800, Geoff Levand wrote:
> 
> It seems platforms/cell should have the shared and/or generic code,
> and the other
> stuff moved into a new platform directory, but is it worth the
> effort? 

No, platforms/xxx isn't supposed to be shared code. That's was syslib is
for.

Ben.
