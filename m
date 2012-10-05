Return-Path: <geoff@infradead.org>
Message-ID: <1349454169.3106.6.camel@clam>
Subject: Re: [Cbe-oss-dev] [PATCH 4/5] Rename the drivers/of prom_*
 functions to of_*
From: Geoff Levand <geoff@infradead.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Fri, 05 Oct 2012 09:22:49 -0700
In-Reply-To: <506BA9E6.9050309@linux.vnet.ibm.com>
References: <506B2E63.5090900@linux.vnet.ibm.com>
 <506BA9E6.9050309@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-02 at 21:58 -0500, Nathan Fontenot wrote:
> Rename the prom_*_property routines of the generic OF code to of_*_property.
> This brings them in line with the naming used by the rest of the OF code.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/ps3/os-area.c      |    6 +++---
>  10 files changed, 35 insertions(+), 37 deletions(-)

The ps3 part looks OK.  Please do build test with ps3_defconfig.

Acked-by: Geoff Levand <geoff@infradead.org>
