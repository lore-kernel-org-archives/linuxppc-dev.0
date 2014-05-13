Return-Path: <mikey@neuling.org>
Message-ID: <1399962216.7554.63.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: relocate "config DTL" so KConfig nests
 properly
From: Michael Neuling <mikey@neuling.org>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Tue, 13 May 2014 16:23:36 +1000
In-Reply-To: <1399950599-24826-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1399950599-24826-1-git-send-email-cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Paul Bolle <pebolle@tiscali.nl>, Gavin Shan <shangw@linux.vnet.ibm.com>,
 Li Zhong <zhong@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> powerpc/pseries: relocate "config DTL" so KConfig nests properly

I don't know what that means.  Can you describe it in more detail?

Mikey


On Mon, 2014-05-12 at 20:09 -0700, Cody P Schafer wrote:
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/Kconfig | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platfo=
rms/pseries/Kconfig
> index 2cb8b77..e00dd4d 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -33,6 +33,16 @@ config PPC_SPLPAR
>  	  processors, that is, which share physical processors between
>  	  two or more partitions.
> =20
> +config DTL
> +	bool "Dispatch Trace Log"
> +	depends on PPC_SPLPAR && DEBUG_FS
> +	help
> +	  SPLPAR machines can log hypervisor preempt & dispatch events to a
> +	  kernel buffer. Saying Y here will enable logging these events,
> +	  which are accessible through a debugfs file.
> +
> +	  Say N if you are unsure.
> +
>  config PSERIES_MSI
>         bool
>         depends on PCI_MSI && PPC_PSERIES && EEH
> @@ -122,13 +132,3 @@ config HV_PERF_CTRS
>  	  systems. 24x7 is available on Power 8 systems.
> =20
>            If unsure, select Y.
> -
> -config DTL
> -	bool "Dispatch Trace Log"
> -	depends on PPC_SPLPAR && DEBUG_FS
> -	help
> -	  SPLPAR machines can log hypervisor preempt & dispatch events to a
> -	  kernel buffer. Saying Y here will enable logging these events,
> -	  which are accessible through a debugfs file.
> -
> -	  Say N if you are unsure.
