Return-Path: <decimal@us.ibm.com>
Date: Fri, 20 Oct 2006 09:42:21 -0500 (Central Daylight Time)
From: Dwayne Grant McConnell <decimal@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Correct way to format spufs file output.
In-Reply-To: <200610201638.52404.arnd@arndb.de>
Message-ID: <Pine.WNT.4.64.0610200941530.5976@dwayne>
References: <Pine.WNT.4.64.0610182227120.6056@doodlebug>
	<200610201023.12796.arnd@arndb.de>
	<Pine.WNT.4.64.0610200848580.5976@dwayne>
	<200610201638.52404.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Oct 2006, Arnd Bergmann wrote:

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

Okay. Thanks for considering it. I'll leave the %llu as is.

-- 
Dwayne Grant McConnell <decimal@us.ibm.com>
Lotus Notes Mail: Dwayne McConnell [Mail]/Austin/IBM@IBMUS
Lotus Notes Calendar: Dwayne McConnell [Calendar]/Austin/IBM@IBMUS
