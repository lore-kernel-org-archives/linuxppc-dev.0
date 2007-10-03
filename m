Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18179.943.277895.633795@cargo.ozlabs.ibm.com>
Date: Wed, 3 Oct 2007 12:51:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
In-Reply-To: <200709261145.51926.fenkes@de.ibm.com>
References: <200709261143.24735.fenkes@de.ibm.com>
	<200709261145.51926.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jan-Bernd Themann <themann@de.ibm.com>, Paul Mackerras <pmac@au1.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joachim Fenkes writes:

> Replace struct ibmebus_dev and struct ibmebus_driver with struct of_device
> and struct of_platform_driver, respectively. Match the external ibmebus
> interface and drivers using it.
> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
>  drivers/infiniband/hw/ehca/ehca_classes.h |    2 +-
>  drivers/net/ehea/ehea.h                   |    2 +-
>  include/asm-powerpc/ibmebus.h             |   38 +++------------
>  arch/powerpc/kernel/ibmebus.c             |   28 ++++++-----
>  drivers/infiniband/hw/ehca/ehca_eq.c      |    6 +-
>  drivers/infiniband/hw/ehca/ehca_main.c    |   32 ++++++------
>  drivers/net/ehea/ehea_main.c              |   72 ++++++++++++++--------------

This is somewhat difficult as this patch touches files that are the
responsibility of three different maintainers.  Is it possible to
split the patch into three, one for each maintainer (possibly by
keeping both old and new interfaces around for a little while)?

If not, then you need to get an Acked-by and an agreement that this
change can go via the powerpc.git tree from Roland Dreier and Jeff
Garzik.

Paul.
