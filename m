Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: devicetree-discuss@lists.ozlabs.org
Subject: Re: [RFC PATCH 13/15] dt/serial: Eliminate users of of_platform_{,
	un}register_driver
Date: Thu, 24 Feb 2011 17:34:24 +0100
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043442.20795.4037.stgit@localhost6.localdomain6>
In-Reply-To: <20110223043442.20795.4037.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201102241734.25048.arnd@arndb.de>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 23 February 2011, Grant Likely wrote:
> Get rid of users of of_platform_driver in drivers/serial.  The
> of_platform_{,un}register_driver functions are going away, so the
> users need to be converted to using the platform_bus_type directly.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

of_serial changes look good.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
