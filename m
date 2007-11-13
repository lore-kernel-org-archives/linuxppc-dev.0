Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18233.4856.500931.456778@cargo.ozlabs.ibm.com>
Date: Tue, 13 Nov 2007 13:59:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 1/3] powerpc: mv64x60 - Fix PCI MEM->System Mem window
	setup
In-Reply-To: <20071108015415.GA14900@mag.az.mvista.com>
References: <20071108015415.GA14900@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> mv64x60_config_pci_windows() is now changed to make the windows match
> as described above.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Are any of this series required for 2.6.24?

Paul.
