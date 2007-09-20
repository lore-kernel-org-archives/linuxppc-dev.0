Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18161.53259.540174.870980@cargo.ozlabs.ibm.com>
Date: Thu, 20 Sep 2007 11:42:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git for-2.6.24 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk (1):
      [POWERPC] Remove APUS support from arch/ppc

Andre Detsch (1):
      [POWERPC] spufs: Fix race condition on gang->aff_ref_spu

Anton Vorontsov (3):
      [POWERPC] QE: extern par_io_config_pin and par_io_data_set funcs
      [POWERPC] fsl_soc: add support for fsl_spi
      [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE, register mmc_spi stub

Domen Puncer (1):
      [POWERPC] MPC5200 low power mode

Guennadi Liakhovetski (1):
      [POWERPC] linkstation updates

Jeremy Kerr (6):
      [POWERPC] spufs: Remove asmlinkage from do_spu_create
      [POWERPC] spufs: Remove spu_harvest
      [POWERPC] cell: Unify spufs syscall path
      [POWERPC] spufs: Remove asmlinkage from spufs_calls
      [POWERPC] spufs: Fix restore_decr_wrapped() to match CBE Handbook
      [POWERPC] cell: Remove DEBUG for SPU callbacks

Jesper Juhl (1):
      [POWERPC] Don't cast kmalloc return value in ibmebus.c

John Rigby (1):
      [POWERPC] 52xx: Fix mpc52xx_uart_of_assign to use correct index

Jon Loeliger (2):
      [POWERPC] 86xx: Remove unnecessary loops_per_jiffy initialization code.
      [POWERPC] 85xx: Remove unnecessary loops_per_jiffy initialization code.

Kumar Gala (10):
      ucc_geth: kill unused include
      [POWERPC] 85xx: Renamed mpc8544_ds.c to mpc85xx_ds.c
      [POWERPC] 85xx: Clean up from 85xx_ds rename
      [POWERPC] Handle alignment faults on SPE load/store instructions
      [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
      [POWERPC] DTS cleanup
      [POWERPC] Move PCI nodes to be sibilings with SOC nodes
      [POWERPC] 83xx: Removed PCI exclude of PHB
      [POWERPC] Add cpu feature for SPE handling
      [POWERPC] Fix modpost warnings from head*.S on ppc32

Michael Ellerman (15):
      [POWERPC] spufs: Extract the file descriptor search logic in SPU coredump code
      [POWERPC] spufs: Remove ctx_info and ctx_info_list
      [POWERPC] spufs: Call spu_acquire_saved() before calculating the SPU note sizes
      [POWERPC] spufs: Use computed sizes/#defines rather than literals in SPU coredump code
      [POWERPC] spufs: Write some SPU coredump values as ASCII
      [POWERPC] spufs: Correctly calculate the size of the local-store to dump
      [POWERPC] spufs: Don't return -ENOSYS as extra notes size if spufs is not loaded
      [POWERPC] spufs: Get rid of spufs_coredump_num_notes, it's not needed if we NULL terminate
      [POWERPC] spufs: Internal __spufs_get_foo() routines should take a spu_context *
      [POWERPC] spufs: Add contents of npc file to SPU coredumps
      [POWERPC] spufs: Combine spufs_coredump_calls with spufs_calls
      [POWERPC] spufs: Cleanup ELF coredump extra notes logic
      [POWERPC] spufs: Handle errors in SPU coredump code, and support coredump to a pipe
      [POWERPC] spufs: Respect RLIMIT_CORE in spu coredump code
      [POWERPC] spufs: Add DEFINE_SPUFS_ATTRIBUTE()

Michael Neuling (1):
      [POWERPC] Remove barriers from the SLB shadow buffer update

Olaf Hering (1):
      [POWERPC] Fix pmac_zilog debug arg

Scott Wood (2):
      [POWERPC] fsl_soc.c cleanup
      [PPC] Add clrbits8 and setbits8.

Sebastian Siewior (2):
      [POWERPC] spufs: Make file-internal functions & variables static
      [POWERPC] spufs: Make isolated loader properly aligned

Stephen Rothwell (4):
      [POWERPC] Fix section mismatch in PCI code
      [POWERPC] Remove cmd_line from head*.S
      [POWERPC] Size swapper_pg_dir correctly
      [POWERPC] FWNMI is only used on pSeries

Timur Tabi (2):
      [POWERPC] add clrsetbits macros
      [POWERPC] 86xx: Fix definition of global-utilites structure
