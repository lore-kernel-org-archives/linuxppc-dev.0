Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH 11/15] ppc/cell: beat dma ops cleanup
Date: Thu, 16 Sep 2010 13:23:37 +0200
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-12-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-12-git-send-email-nacc@us.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201009161323.37675.arnd@arndb.de>
Cc: cbe-oss-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 15 September 2010, Nishanth Aravamudan wrote:
> direct_dma_ops is the default pci dma ops.
> 
> No need to call a function to get the pci dma ops, we know they are the
> dma_direct_ops.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
