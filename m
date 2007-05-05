Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 7/13] powerpc: Create Marvell mv64x60 MPSC (serial)
	platform_data
Date: Sat, 5 May 2007 14:26:32 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070502214104.GB27253@xyzzy.farnsworth.org>
	<20070504210315.GA3166@xyzzy.farnsworth.org>
In-Reply-To: <20070504210315.GA3166@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705051426.32627.arnd@arndb.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 May 2007, Dale Farnsworth wrote:
> This patch creates platform_device entries for the Marvell mv64x60
> MPSC (multi-protocol serial controller) ports, based on information
> contained in the device tree.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
