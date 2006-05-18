Return-Path: <olof@lixom.net>
Date: Thu, 18 May 2006 12:13:29 -0500
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc: pseries: Use generic dma-window parsing
	function
Message-ID: <20060518171329.GF8220@pb15.lixom.net>
References: <1147933975.516311.850847048300.qpush@pokey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147933975.516311.850847048300.qpush@pokey>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 18, 2006 at 04:32:55PM +1000, Jeremy Kerr wrote:
> Change the pseries iommu init code to use the new of_parse_dma_window()
> to parse the ibm,dma-window and ibm,my-dma-window properties of pci and
> virtual device nodes.
> 
> Also, clean up vio_build_iommu_table() a little.
> 
> Tested on pseries, with both vio and pci devices.
> 
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Acked-by: Olof Johansson <olof@lixom.net>
