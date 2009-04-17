Return-Path: <subrata@linux.vnet.ibm.com>
Subject: Re: [BUILD FAILURE 03/12] Next April 14 : PPC64
	randconfig	[arch/powerpc/platforms/ps3/setup.c]
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <49E787DC.2050800@am.sony.com>
References: <1239733704.5344.75.camel@subratamodak.linux.ibm.com>
	<49E787DC.2050800@am.sony.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 17 Apr 2009 11:17:18 +0530
Message-Id: <1239947239.4875.6.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Alexander Beregalov <a.beregalov@gmail.com>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-16 at 12:32 -0700, Geoff Levand wrote:
> On 04/14/2009 11:28 AM, Subrata Modak wrote:
> > Observed the following build error:
> > ---
> > arch/powerpc/platforms/ps3/setup.c:49: error: redefinition of
> > ‘smp_send_stop’
> > include/linux/smp.h:125: error: previous definition of ‘smp_send_stop’
> > was here
> 
> Hi Subrata,
> 
> Thanks for the report.  I submitted a fix to the powerpc ML:
> 
>  http://patchwork.ozlabs.org/patch/26084/

Thanks Geoff.

Regards--
Subrata

> 
> -Geoff
> 
