Return-Path: <michael.barkowski@freescale.com>
Message-ID: <45FAD268.1040403@freescale.com>
Date: Fri, 16 Mar 2007 12:22:48 -0500
From: Michael Barkowski <michael.barkowski@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.22] Add MPC832x RDB board.
References: <45FABEEC.7040407@freescale.com>
	<CC7F67C6-0E80-4DAE-88A0-0AD2B5ED179E@kernel.crashing.org>
	<45FACF40.9000405@freescale.com>
	<072D59B7-FC61-4E0D-B8C6-D2B107257814@kernel.crashing.org>
In-Reply-To: <072D59B7-FC61-4E0D-B8C6-D2B107257814@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Mar 16, 2007, at 12:09 PM, Michael Barkowski wrote:
> 
> 
>>Kumar Gala wrote:
>>
>>>On Mar 16, 2007, at 10:59 AM, Michael Barkowski wrote:
>>>
>>>
>>>
>>>>Add support for the MPC8323E Reference Development Board (RDB).
>>>>The board
>>>>is a mini-ITX reference board with 64M DDR2, 16M flash, USB, PCI,
>>>>10/100 ethernet, serial, and phone ports.
>>>>
>>>>Signed-off-by: Michael Barkowski <michael.barkowski@freescale.com>
>>>>Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>>>>---
>>>>Please consider for 2.6.22.  Applies cleanly to for-2.6.22 branch
>>>>on Paul's tree.
>>>>
>>>>arch/powerpc/boot/dts/mpc832x_rdb.dts      |  294 +++++++
>>>>arch/powerpc/configs/mpc832x_rdb_defconfig | 1292 +++++++++++++++++
>>>>+++++++++++
>>>>arch/powerpc/platforms/83xx/Kconfig        |    9 +-
>>>>arch/powerpc/platforms/83xx/Makefile       |    1 +
>>>>arch/powerpc/platforms/83xx/mpc832x_rdb.c  |  138 +++
>>>>5 files changed, 1733 insertions(+), 1 deletions(-)
>>>>create mode 100644 arch/powerpc/boot/dts/mpc832x_rdb.dts
>>>>create mode 100644 arch/powerpc/configs/mpc832x_rdb_defconfig
>>>>create mode 100644 arch/powerpc/platforms/83xx/mpc832x_rdb.c
>>>
>>>
>>>Who different is the 8323E rdb from the 8313 rdb?
>>
>>QE Lite 10/100 vs. TSEC
>>no FPU (e300c2).
>>PCI-based USB 2.0 hub vs. fsl USB gadget
>>64M DDR2
>>smaller size...
> 
> 
> You also mentioned phone ports, do you know what's involved in  
> supporting those (from a sw point of view)?
> 
> - k

It's an SPI and TDM interface to a Legerity Le88221 SLIC Codec.
