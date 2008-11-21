Return-Path: <dgibson@ozlabs.org>
Date: Fri, 21 Nov 2008 11:35:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Add support for the nwp serial device
Message-ID: <20081121003545.GC13049@yookeroo.seuss>
References: <200811201501.24000.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200811201501.24000.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2008 at 03:01:23PM +0100, Arnd Bergmann wrote:
> From: Benjamin Krill <ben@codiert.org>
> 
> This patch adds support for the nwp serial device which is connected to
> a DCR bus. It uses the of_serial device driver to determine necessary
> properties from the device tree. The supported device is added as serial
> port number 84.

Uh.. registers as port number 84??  What's this random number about?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
