Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] Correct way to format spufs file output.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200610201638.52404.arnd@arndb.de>
References: <Pine.WNT.4.64.0610182227120.6056@doodlebug>
	<200610201023.12796.arnd@arndb.de>
	<Pine.WNT.4.64.0610200848580.5976@dwayne>
	<200610201638.52404.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 11:44:53 +1000
Message-Id: <1161395093.10524.225.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dwayne Grant McConnell <decimal@us.ibm.com>,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-20 at 16:38 +0200, Arnd Bergmann wrote:
> On Friday 20 October 2006 15:54, Dwayne Grant McConnell wrote:
> > I think %0xllx is the way to go. I would even advocate changing 
> > signal1_type and signal2_type unless it is actually too dangerous.
> 
> There is absolutely no reason why these should be hexadecimal, they
> are basically implementing a bool.
> 
> > Is there even a case where changing from %llu to %0xllx would break things? 
> > Perhaps with the combination of a old library with a new kernel?
> 
> Right, a library or some script that has been written assuming there
> is no leading 0x.

We might still want to "broadcast" that we might change that and see how
much gets broken. It's very likely that nothing will.

Ben.
