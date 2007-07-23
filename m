Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [70.61.120.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E21ADDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jul 2007 00:05:58 +1000 (EST)
Date: Mon, 23 Jul 2007 09:22:25 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [PATCH][12/37] Clean up duplicate includes in drivers/net/
Message-ID: <20070723132225.GA3723@tuxdriver.com>
References: <200707211702.46375.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707211702.46375.jesper.juhl@gmail.com>
Cc: info@netxen.com, Luke Yang <luke.yang@analog.com>,
	Judy Fischbach <jfisch@cs.pdx.edu>, Patrick McHardy <kaber@coreworks.de>,
	bonding-devel@lists.sourceforge.net,
	Bryan Wu <bryan.wu@analog.com>, kong.lai@tundra.com,
	Jay Vosburgh <fubar@us.ibm.com>,
	James Morris <jmorris@namei.org>, linuxppc-embedded@ozlabs.org,
	Daniel Drake <dsd@gentoo.org>, Alex V Lasso <a_villacis@palosanto.com>,
	Ulrich Kunitz <kune@deine-taler.de>,
	Chad Tindel <ctindel@users.sourceforge.net>,
	Amit S Kale <amitkale@netxen.com>, Jay Cliburn <jcliburn@gmail.com>,
	Samuel Ortiz <samuel@sortiz.org>, Brian Pugh <bpugh@cs.pdx.edu>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Chris Snook <csnook@redhat.com>, alexandre.bounine@tundra.com,
	Pantelis Antoniou <panto@intracom.gr>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>, Vitaly Bordug <vbordug@ru.mvista.com>,
	Lukasz Stelmach <stlman@poczta.fm>, Ron Mercer <linux-driver@qlogic.com>,
	atl1-devel@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	James P Ketrenos <ipw2100-admin@linux.intel.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Jul 21, 2007 at 05:02:45PM +0200, Jesper Juhl wrote:
> Hi,
> 
> This patch cleans up duplicate includes in
> 	 drivers/net/
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

> diff --git a/drivers/net/wireless/ipw2200.h b/drivers/net/wireless/ipw2200.h
> index 626a240..9c973b9 100644
> --- a/drivers/net/wireless/ipw2200.h
> +++ b/drivers/net/wireless/ipw2200.h
> @@ -45,7 +45,6 @@
>  
>  #include <linux/firmware.h>
>  #include <linux/wireless.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/jiffies.h>
>  #include <asm/io.h>
>  
> diff --git a/drivers/net/wireless/zd1211rw/zd_def.h b/drivers/net/wireless/zd1211rw/zd_def.h
> index deb99d1..505b4d7 100644
> --- a/drivers/net/wireless/zd1211rw/zd_def.h
> +++ b/drivers/net/wireless/zd1211rw/zd_def.h
> @@ -21,7 +21,6 @@
>  #include <linux/kernel.h>
>  #include <linux/stringify.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
>  
>  typedef u16 __nocast zd_addr_t;

ACK

-- 
John W. Linville
linville@tuxdriver.com
