Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <1239733836.5344.83.camel@subratamodak.linux.ibm.com>
References: <1239733836.5344.83.camel@subratamodak.linux.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 14 Apr 2009 12:42:47 -0600
Message-ID: <fa686aa40904141142s3717812ep293973fefce8853d@mail.gmail.com>
Subject: Re: [BUILD FAILURE 11/12] Next April 14 : PPC64 randconfig
	[drivers/spi/mpc52xx_psc_spi.c]
To: subrata@linux.vnet.ibm.com
Content-Type: text/plain; charset=windows-1252
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	David Brownell <dbrownell@users.sourceforge.net>, Greg KH <greg@kroah.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Subrata.  I'll look into this.

g.

On Tue, Apr 14, 2009 at 12:30 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Observed the following build error:
> ---
> CC =A0 =A0 =A0drivers/spi/mpc52xx_psc_spi.o
> drivers/spi/mpc52xx_psc_spi.c: In function =91mpc52xx_psc_spi_do_probe=92=
:
> drivers/spi/mpc52xx_psc_spi.c:398: error: =91struct fsl_spi_platform_data=
=92
> has no member named =91activate_cs=92
> drivers/spi/mpc52xx_psc_spi.c:399: error: =91struct fsl_spi_platform_data=
=92
> has no member named =91deactivate_cs=92
> make[2]: *** [drivers/spi/mpc52xx_psc_spi.o] Error 1
> make[1]: *** [drivers/spi] Error 2
> make: *** [drivers] Error 2
> ---
>
> Regards--
> Subrata
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
