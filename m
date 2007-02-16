Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17876.64475.232797.997009@cargo.ozlabs.ibm.com>
Date: Fri, 16 Feb 2007 11:33:31 +1100
From: Paul Mackerras <paulus@samba.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3] powerpc: add of_get_mac_address() and update fsl_soc.c
	to use it
In-Reply-To: <11714756473819-git-send-email-timur@freescale.com>
References: <11714756473819-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi writes:

> Add function of_get_mac_address(), which obtains the best MAC address to use
> from the device tree by checking various properties in order.  The order is:
> 'mac-address', then 'local-mac-address', then 'address'.  It skips properties 
> that contain invalid MAC addresses, which were probably not initialized
> by U-Boot.

Looks OK except that of_get_mac_address should go in prom_parse.c, not
prom.c.

Paul.
