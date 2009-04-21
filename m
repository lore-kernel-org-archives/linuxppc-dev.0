Return-Path: <olof@lixom.net>
Date: Tue, 21 Apr 2009 12:25:02 -0500
From: Olof Johansson <olof@lixom.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch] powerpc/pasemi: Fix no SMP build error
Message-ID: <20090421172502.GA20237@lixom.net>
References: <1239285094.5188.65.camel@subratamodak.linux.ibm.com>
	<49E8B015.7060808@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49E8B015.7060808@am.sony.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>, subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 09:36:37AM -0700, Geoff Levand wrote:
> A non-SMP version of smp_send_stop() is now included in smp.h.
> Remove the unneeded def in the pasemi setup.c.
> 
> Fixes build errors like these when CONFIG_SMP=n:
> 
>   arch/powerpc/platforms/pasemi/setup.c:48: error: redefinition of ???smp_send_stop???
>   include/linux/smp.h:125: error: previous definition of 'smp_send_stop' was here

Thanks for taking care of this.

> Reported-by: subrata@linux.vnet.ibm.com
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


Acked-by: Olof Johansson <olof@lixom.net>


-Olof
