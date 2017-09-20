Return-Path: <fengguang.wu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxpKQ44J7zDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 15:32:25 +1000 (AEST)
Date: Wed, 20 Sep 2017 13:31:41 +0800
From: kbuild test robot <lkp@intel.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, bhelgaas@google.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: Re: [PATCH v1 1/3] powerpc/kernel: Split up pci_bus_add_device
Message-ID: <201709201310.dKM5ZVgY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
In-Reply-To: <20170918192651.78404-2-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bryant,

[auto build test WARNING on powerpc/next]
[also build test WARNING on v4.14-rc1 next-20170919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bryant-G-Ly/Prepartion-for-SR-IOV-PowerVM-Enablement/20170920-114754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/init.h:1: warning: no structured comments found
   include/linux/mod_devicetable.h:687: warning: Excess struct/union/enum/typedef member 'ver_major' description in 'fsl_mc_device_id'
   include/linux/mod_devicetable.h:687: warning: Excess struct/union/enum/typedef member 'ver_minor' description in 'fsl_mc_device_id'
   kernel/sched/core.c:2080: warning: No description found for parameter 'rf'
   kernel/sched/core.c:2080: warning: Excess function parameter 'cookie' description in 'try_to_wake_up_local'
   include/linux/wait.h:555: warning: No description found for parameter 'wq'
   include/linux/wait.h:555: warning: Excess function parameter 'wq_head' description in 'wait_event_interruptible_hrtimeout'
   include/linux/wait.h:759: warning: No description found for parameter 'wq_head'
   include/linux/wait.h:759: warning: Excess function parameter 'wq' description in 'wait_event_killable'
   include/linux/kthread.h:26: warning: Excess function parameter '...' description in 'kthread_create'
   kernel/sys.c:1: warning: no structured comments found
   include/linux/device.h:968: warning: No description found for parameter 'dma_ops'
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   include/linux/iio/iio.h:603: warning: No description found for parameter 'trig_readonly'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'indio_dev'
   include/linux/iio/trigger.h:151: warning: No description found for parameter 'trig'
   include/linux/device.h:969: warning: No description found for parameter 'dma_ops'
   drivers/ata/libata-eh.c:1449: warning: No description found for parameter 'link'
   drivers/ata/libata-eh.c:1449: warning: Excess function parameter 'ap' description in 'ata_eh_done'
   drivers/ata/libata-eh.c:1590: warning: No description found for parameter 'qc'
   drivers/ata/libata-eh.c:1590: warning: Excess function parameter 'dev' description in 'ata_eh_request_sense'
   drivers/mtd/nand/nand_base.c:2751: warning: Excess function parameter 'cached' description in 'nand_write_page'
   drivers/mtd/nand/nand_base.c:2751: warning: Excess function parameter 'cached' description in 'nand_write_page'
>> drivers/pci/bus.c:351: warning: No description found for parameter 'pdev'
>> drivers/pci/bus.c:351: warning: Excess function parameter 'dev' description in 'pci_bus_add_virtfn_device'
   arch/s390/include/asm/cmb.h:1: warning: no structured comments found
   drivers/scsi/scsi_lib.c:1116: warning: No description found for parameter 'rq'
   drivers/scsi/constants.c:1: warning: no structured comments found
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'claimed'
   include/linux/usb/gadget.h:230: warning: No description found for parameter 'enabled'
   include/linux/usb/gadget.h:412: warning: No description found for parameter 'quirk_altset_not_supp'
   include/linux/usb/gadget.h:412: warning: No description found for parameter 'quirk_stall_not_supp'
   include/linux/usb/gadget.h:412: warning: No description found for parameter 'quirk_zlp_not_supp'
   fs/inode.c:1666: warning: No description found for parameter 'rcu'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_transaction'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_next_transaction'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_list'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_vfs_inode'
   include/linux/jbd2.h:443: warning: No description found for parameter 'i_flags'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_rsv_handle'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_reserved'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_type'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_line_no'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_start_jiffies'
   include/linux/jbd2.h:497: warning: No description found for parameter 'h_requested_credits'
   include/linux/jbd2.h:497: warning: No description found for parameter 'saved_alloc_context'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chkpt_bhs'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_devname'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_average_commit_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_min_batch_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_max_batch_time'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_commit_callback'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_failed_commit'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_chksum_driver'
   include/linux/jbd2.h:1050: warning: No description found for parameter 'j_csum_seed'
   fs/jbd2/transaction.c:511: warning: No description found for parameter 'type'
   fs/jbd2/transaction.c:511: warning: No description found for parameter 'line_no'
   fs/jbd2/transaction.c:641: warning: No description found for parameter 'gfp_mask'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'set_busid'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'debugfs_init'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_open_object'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_close_object'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'prime_handle_to_fd'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'prime_fd_to_handle'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_export'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_import'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_pin'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_unpin'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_res_obj'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_get_sg_table'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_import_sg_table'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_vmap'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_vunmap'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_prime_mmap'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'gem_vm_ops'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'major'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'minor'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'patchlevel'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'name'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'desc'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'date'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'driver_features'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'ioctls'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'num_ioctls'
   include/drm/drm_drv.h:537: warning: No description found for parameter 'fops'
   include/drm/drm_color_mgmt.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_syncobj.c:341: warning: Excess function parameter 'dev' description in 'drm_syncobj_open'
   drivers/gpu/drm/drm_syncobj.c:366: warning: Excess function parameter 'dev' description in 'drm_syncobj_release'
   include/drm/drm_syncobj.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_syncobj.c:342: warning: Excess function parameter 'dev' description in 'drm_syncobj_open'
   drivers/gpu/drm/drm_syncobj.c:367: warning: Excess function parameter 'dev' description in 'drm_syncobj_release'
   drivers/gpu/host1x/bus.c:50: warning: Excess function parameter 'driver' description in 'host1x_subdev_add'
   Documentation/doc-guide/sphinx.rst:121: ERROR: Unknown target name: "sphinx c domain".
   kernel/sched/fair.c:7584: WARNING: Inline emphasis start-string without end-string.
   kernel/time/timer.c:1200: ERROR: Unexpected indentation.
   kernel/time/timer.c:1202: ERROR: Unexpected indentation.
   kernel/time/timer.c:1203: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:108: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/wait.h:111: ERROR: Unexpected indentation.
   include/linux/wait.h:113: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/time/hrtimer.c:991: WARNING: Block quote ends without a blank line; unexpected unindent.
   kernel/signal.c:323: WARNING: Inline literal start-string without end-string.
   kernel/rcu/tree.c:3187: ERROR: Unexpected indentation.
   kernel/rcu/tree.c:3214: ERROR: Unexpected indentation.
   kernel/rcu/tree.c:3215: WARNING: Bullet list ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:219: ERROR: Unexpected indentation.
   include/linux/iio/iio.h:220: WARNING: Block quote ends without a blank line; unexpected unindent.
   include/linux/iio/iio.h:226: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/iio/industrialio-core.c:633: ERROR: Unknown target name: "iio_val".
   drivers/iio/industrialio-core.c:640: ERROR: Unknown target name: "iio_val".
   drivers/ata/libata-core.c:5906: ERROR: Unknown target name: "hw".
   drivers/message/fusion/mptbase.c:5051: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/tty/serial/serial_core.c:1897: WARNING: Definition list ends without a blank line; unexpected unindent.
   drivers/pci/pci.c:3470: ERROR: Unexpected indentation.
   include/linux/regulator/driver.h:271: ERROR: Unknown target name: "regulator_regmap_x_voltage".
   include/linux/spi/spi.h:373: ERROR: Unexpected indentation.
   drivers/w1/w1_io.c:196: WARNING: Definition list ends without a blank line; unexpected unindent.
   block/bio.c:404: ERROR: Unknown target name: "gfp".
   drivers/gpu/drm/drm_scdc_helper.c:203: ERROR: Unexpected indentation.
   drivers/gpu/drm/drm_scdc_helper.c:204: WARNING: Block quote ends without a blank line; unexpected unindent.
   drivers/gpu/drm/drm_ioctl.c:702: WARNING: Definition list ends without a blank line; unexpected unindent.
   Documentation/gpu/todo.rst:111: ERROR: Unknown target name: "drm_fb".
   sound/soc/soc-core.c:2703: ERROR: Unknown target name: "snd_soc_daifmt".
   sound/core/jack.c:312: ERROR: Unknown target name: "snd_jack_btn".
   Documentation/media/v4l-drivers/imx.rst:: WARNING: document isn't included in any toctree

vim +/pdev +351 drivers/pci/bus.c

   340	
   341	/**
   342	 * pci_bus_add_virtfn_device - start driver for a virtual function device
   343	 * @dev: device to add
   344	 *
   345	 * This adds add sysfs entries and start device drivers for
   346	 * virtual function devices
   347	 *
   348	 */
   349	void pci_bus_add_virtfn_device(struct pci_dev *pdev)
   350	{
 > 351		pci_bus_add_sysfs_entries(pdev);
   352		pci_bus_match_virtfn_driver(pdev);
   353	}
   354	EXPORT_SYMBOL_GPL(pci_bus_add_virtfn_device);
   355	#endif
   356	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--qDbXVdCdHGoSgWSk
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--qDbXVdCdHGoSgWSk--
