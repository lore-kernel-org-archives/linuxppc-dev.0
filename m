Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18476.327.432007.66792@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 19:24:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: linux-next: powercp-next build failure
In-Reply-To: <20080515145913.5436adb9.sfr@canb.auug.org.au>
References: <20080515145913.5436adb9.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-next@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> drivers/of/device.c: In function `modalias_show':
> drivers/of/device.c:66: error: implicit declaration of function `of_device_get_modalias'

Dave, how would you prefer to fix this?  We could move
of_device_get_modalias into drivers/of/device.c, or I could simply
revert that commit.

Paul.
