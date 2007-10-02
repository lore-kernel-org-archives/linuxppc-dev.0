Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 5F83DDDF48
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:30:06 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so2369920uge
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:30:04 -0700 (PDT)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 08/18] Uartlite: Add macro for uartlite device name
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181726.18608.73695.stgit@trillian.cg.shawcable.net>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 02 Oct 2007 17:29:57 +0200
In-Reply-To: <20070928181726.18608.73695.stgit@trillian.cg.shawcable.net>
	(Grant Likely's message of "Fri\, 28 Sep 2007 12\:17\:28 -0600")
Message-ID: <87ejgd356y.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> From: Grant Likely <grant.likely@secretlab.ca>
 Grant> Changed to make the OF bus binding a wee bit cleaner

 Grant> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
 Grant> ---

 Grant>  arch/powerpc/platforms/40x/Kconfig |    4 ++--
 Grant>  drivers/serial/uartlite.c          |    5 +++--
 Grant>  2 files changed, 5 insertions(+), 4 deletions(-)

 Grant> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
 Grant> index 1aae0e6..44f08dd 100644
 Grant> --- a/arch/powerpc/platforms/40x/Kconfig
 Grant> +++ b/arch/powerpc/platforms/40x/Kconfig
 Grant> @@ -65,8 +65,8 @@ config XILINX_VIRTEX_GENERIC_BOARD
 Grant>  	bool "Generic Xilinx Virtex board"
 Grant>  	depends on 40x
 Grant>  	default y
 Grant> -	select VIRTEX_II_PRO
 Grant> -	select VIRTEX_4_FX
 Grant> +	select XILINX_VIRTEX_II_PRO
 Grant> +	select XILINX_VIRTEX_4_FX

Huh? What does this have to do with $SUBJ?

 Grant>  	help
 Grant>  	  This option enables generic support for Xilinx Virtex based boards.
 
 Grant> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
 Grant> index ae05a67..10e0da9 100644
 Grant> --- a/drivers/serial/uartlite.c
 Grant> +++ b/drivers/serial/uartlite.c
 Grant> @@ -18,6 +18,7 @@
 Grant>  #include <linux/interrupt.h>
 Grant>  #include <asm/io.h>
 
 Grant> +#define ULITE_NAME		"ttyUL"
 Grant>  #define ULITE_MAJOR		204
 Grant>  #define ULITE_MINOR		187
 Grant>  #define ULITE_NR_UARTS		4

Otherwise Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
