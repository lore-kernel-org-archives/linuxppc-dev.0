Return-Path: <kou.ishizaki@toshiba.co.jp>
Date: Wed, 29 Aug 2007 17:56:14 +0900 (JST)
Message-Id: <20070829.175614.-1300543370.kouish@swc.toshiba.co.jp>
To: krafft@de.ibm.com
Subject: Re: [Cbe-oss-dev] [patch 1/5] spu_manage: use newer physical-id
In-Reply-To: <20070828162011.5356afaa@localhost>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Christian Krafft wrote:
> On Thu, 23 Aug 2007 18:12:19 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Thursday 23 August 2007, kou.ishizaki@toshiba.co.jp wrote:
> > > Please check "unit-id" if "physical-id" doesn't exist. Because
Celleb
> > > uses "unit-id" to provide spe_id.
> 
> Sorry for the late answer, wasn't on cc
> and had to receive all mails of the last 6 month once again :-(
> 
> Can you check if the patch below is working with celleb device tree ?
> 
> ------
> Subject: spu_manage: fix spu_unit_number for celleb device tree
> 
> From: Christian Krafft <krafft@de.ibm.com>
> 
> New device trees provide "physical-id".
> Celleb device tree provide the "unit-id".
> Legacy device tree used the reg property for the physical id of an
spe.
> This patch fixes find_spu_unit_number to look for the spu id in that
order.
> The length is checked to avoid misinterpretation in case the
attributes
> unit-id or reg do not contain the id.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Acked-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

It works good on Celleb, thanks.  Please apply it to 2.6.23.

Best regards,
Kou Ishizaki
