Return-Path: <jbarnes@virtuousgeek.org>
Received: from outbound-mail-22.bluehost.com (outbound-mail-22.bluehost.com
	[69.89.21.17]) by ozlabs.org (Postfix) with SMTP id 2C2A9DE035
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 08:16:28 +1000 (EST)
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH 2/2] powerpc: Add legacy PCI access via sysfs
Date: Fri, 3 Oct 2008 15:09:43 -0700
References: <20081003094953.A7F4EDE184@ozlabs.org>
	<200810030859.12335.jbarnes@virtuousgeek.org>
	<1223070723.12264.213.camel@pasglop>
In-Reply-To: <1223070723.12264.213.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200810031509.44407.jbarnes@virtuousgeek.org>
Cc: linuxppc-dev@ozlabs.org, tony.luck@intel.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday, October 3, 2008 2:52 pm Benjamin Herrenschmidt wrote:
> On Fri, 2008-10-03 at 08:59 -0700, Jesse Barnes wrote:
> > Feel free to change the generic code if it makes things easier for you,
> > the only limitation is that we have to live within the generic sysfs
> > read/write functions.  Obviously I didn't worry about it when doing this
> > code on ia64...
>
> I started to do that and then decided not to bother...

Well than you can at least update the comment in the ppc platform code 
from "The generic code is idiotic" to "The generic code is idiotic and I'm 
too lazy to fix it". :)

-- 
Jesse Barnes, Intel Open Source Technology Center
