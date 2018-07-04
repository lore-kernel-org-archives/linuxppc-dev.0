Return-Path: <lkp@intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LS6B0kR3zF1QS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:05:05 +1000 (AEST)
Date: Thu, 5 Jul 2018 01:04:30 +0800
From: kbuild test robot <lkp@intel.com>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 2/4] drivers/base: utilize device tree info to shutdown
 devices
Message-ID: <201807050050.KEt5N2jd%fengguang.wu@intel.com>
References: <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
In-Reply-To: <1530600642-25090-3-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pingfan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on v4.18-rc3 next-20180704]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pingfan-Liu/drivers-base-bugfix-for-supplier-consumer-ordering-in-device_kset/20180703-184317
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   mm/mempool.c:228: warning: Function parameter or member 'pool' not described in 'mempool_init'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4279: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2282: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:955: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'status_stats.avg_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:588: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   kernel/sched/fair.c:3760: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'
   include/linux/device.h:93: warning: bad line: this bus.
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:307: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/gpio/driver.h:142: warning: Function parameter or member 'request_key' not described in 'gpio_irq_chip'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/device.h:94: warning: bad line: this bus.
>> include/linux/device.h:1008: warning: Function parameter or member 'shutdown' not described in 'device'
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/regulator/driver.h:227: warning: Function parameter or member 'resume_early' not described in 'regulator_ops'
   drivers/regulator/core.c:4465: warning: Excess function parameter 'state' description in 'regulator_suspend_late'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/usb/dwc3/gadget.c:510: warning: Excess function parameter 'dwc' description in 'dwc3_gadget_start_config'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:610: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   drivers/gpu/drm/i915/i915_vma.h:48: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   include/drm/tinydrm/tinydrm.h:34: warning: Function parameter or member 'fb_dirty' not described in 'tinydrm_device'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'crtc_state' not described in 'mipi_dbi_enable_flush'
   drivers/gpu/drm/tinydrm/mipi-dbi.c:272: warning: Function parameter or member 'plane_state' not described in 'mipi_dbi_enable_flush'

vim +1008 include/linux/device.h

^1da177e Linus Torvalds 2005-04-16 @1008  

:::::: The code at line 1008 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vQEfM5zExfsPwbgr9upZAAA=

--RnlQjJ0d97Da+TV1--
