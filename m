Return-Path: <hch@lst.de>
Date: Sun, 10 May 2009 21:08:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 08/15] powerpc/cell: Extract duplicated IOPTE_* to
	<asm/iommu.h>
Message-ID: <20090510190825.GB23659@lst.de>
References: <1241791284-11490-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1241791284-11490-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1241791284-11490-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 08, 2009 at 04:01:17PM +0200, Geert Uytterhoeven wrote:
> +/* Cell page table entries */
> +#define IOPTE_PP_W		0x8000000000000000ul /* protection: write */
> +#define IOPTE_PP_R		0x4000000000000000ul /* protection: read */
> +#define IOPTE_M			0x2000000000000000ul /* coherency required */
> +#define IOPTE_SO_R		0x1000000000000000ul /* ordering: writes */
> +#define IOPTE_SO_RW             0x1800000000000000ul /* ordering: r & w */
> +#define IOPTE_RPN_Mask		0x07fffffffffff000ul /* RPN */
> +#define IOPTE_H			0x0000000000000800ul /* cache hint */
> +#define IOPTE_IOID_Mask		0x00000000000007fful /* ioid */

If this is in a global header it should probably have a CELL_ prefix.
