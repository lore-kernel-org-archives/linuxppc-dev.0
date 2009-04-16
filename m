Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <49E787DC.2050800@am.sony.com>
Date: Thu, 16 Apr 2009 12:32:44 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: subrata@linux.vnet.ibm.com
Subject: Re: [BUILD FAILURE 03/12] Next April 14 : PPC64
	randconfig	[arch/powerpc/platforms/ps3/setup.c]
References: <1239733704.5344.75.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1239733704.5344.75.camel@subratamodak.linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 04/14/2009 11:28 AM, Subrata Modak wrote:
> Observed the following build error:
> ---
> arch/powerpc/platforms/ps3/setup.c:49: error: redefinition of
> =E2=80=98smp_send_stop=E2=80=99
> include/linux/smp.h:125: error: previous definition of =E2=80=98smp_sen=
d_stop=E2=80=99
> was here

Hi Subrata,

Thanks for the report.  I submitted a fix to the powerpc ML:

 http://patchwork.ozlabs.org/patch/26084/

-Geoff
