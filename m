Date: Tue, 24 Oct 2000 22:18:17 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
Message-ID: <20001024221817.A24315@suse.de>
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
In-Reply-To: <14837.11341.207379.903189@argo.linuxcare.com.au>; from paulus@linuxcare.com.au on Tue, Oct 24, 2000 at 05:29:33PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 24, Paul Mackerras wrote:


> I'll be interested to hear how people go with it.  I'll check the
> changes into the bitkeeper linuxppc_2_2 tree within the next day or
> so.  If it goes OK I'll send the patch to Alan for inclusion in
> 2.2.18.

This is what I get whit a prep only config.
I will send the .config to you in a separate mail.

Is there a way to not compile the pmac_*.c stuff when pmac is not
defined? At least for 2.2?

Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="build.log"

arch/ppc/kernel/kernel.o: In function `pmac_set_rtc_time':
arch/ppc/kernel/kernel.o(.text+0x7dc6): undefined reference to `adb_controller'
arch/ppc/kernel/kernel.o(.text+0x7dca): undefined reference to `adb_controller'
arch/ppc/kernel/kernel.o(.text+0x7e18): undefined reference to `cuda_request'
arch/ppc/kernel/kernel.o(.text+0x7e18): relocation truncated to fit: R_PPC_REL24 cuda_request
arch/ppc/kernel/kernel.o(.text+0x7e28): undefined reference to `cuda_poll'
arch/ppc/kernel/kernel.o(.text+0x7e28): relocation truncated to fit: R_PPC_REL24 cuda_poll
arch/ppc/kernel/kernel.o(.text+0x7e64): undefined reference to `pmu_request'
arch/ppc/kernel/kernel.o(.text+0x7e64): relocation truncated to fit: R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text+0x7e74): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o(.text+0x7e74): relocation truncated to fit: R_PPC_REL24 pmu_poll
arch/ppc/kernel/kernel.o: In function `pmac_restart':
arch/ppc/kernel/kernel.o(.text+0x8306): undefined reference to `adb_hardware'
arch/ppc/kernel/kernel.o(.text+0x830a): undefined reference to `adb_hardware'
arch/ppc/kernel/kernel.o(.text+0x8334): undefined reference to `cuda_request'
arch/ppc/kernel/kernel.o(.text+0x8334): relocation truncated to fit: R_PPC_REL24 cuda_request
arch/ppc/kernel/kernel.o(.text+0x8338): undefined reference to `cuda_poll'
arch/ppc/kernel/kernel.o(.text+0x8338): relocation truncated to fit: R_PPC_REL24 cuda_poll
arch/ppc/kernel/kernel.o(.text+0x8340): undefined reference to `pmu_restart'
arch/ppc/kernel/kernel.o(.text+0x8340): relocation truncated to fit: R_PPC_REL24 pmu_restart
arch/ppc/kernel/kernel.o: In function `pmac_power_off':
arch/ppc/kernel/kernel.o(.text+0x8366): undefined reference to `adb_hardware'
arch/ppc/kernel/kernel.o(.text+0x836a): undefined reference to `adb_hardware'
arch/ppc/kernel/kernel.o(.text+0x8394): undefined reference to `cuda_request'
arch/ppc/kernel/kernel.o(.text+0x8394): relocation truncated to fit: R_PPC_REL24 cuda_request
arch/ppc/kernel/kernel.o(.text+0x8398): undefined reference to `cuda_poll'
arch/ppc/kernel/kernel.o(.text+0x8398): relocation truncated to fit: R_PPC_REL24 cuda_poll
arch/ppc/kernel/kernel.o(.text+0x83a0): undefined reference to `pmu_shutdown'
arch/ppc/kernel/kernel.o(.text+0x83a0): relocation truncated to fit: R_PPC_REL24 pmu_shutdown
arch/ppc/kernel/kernel.o: In function `pmac_get_rtc_time':
arch/ppc/kernel/kernel.o(.text.pmac+0xe): undefined reference to `adb_controller'
arch/ppc/kernel/kernel.o(.text.pmac+0x12): undefined reference to `adb_controller'
arch/ppc/kernel/kernel.o(.text.pmac+0x48): undefined reference to `cuda_request'
arch/ppc/kernel/kernel.o(.text.pmac+0x48): relocation truncated to fit: R_PPC_REL24 cuda_request
arch/ppc/kernel/kernel.o(.text.pmac+0x58): undefined reference to `cuda_poll'
arch/ppc/kernel/kernel.o(.text.pmac+0x58): relocation truncated to fit: R_PPC_REL24 cuda_poll
arch/ppc/kernel/kernel.o(.text.pmac+0xb4): undefined reference to `pmu_request'
arch/ppc/kernel/kernel.o(.text.pmac+0xb4): relocation truncated to fit: R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text.pmac+0xd0): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o(.text.pmac+0xd0): relocation truncated to fit: R_PPC_REL24 pmu_poll
arch/ppc/kernel/kernel.o: In function `nvram_read_byte':
arch/ppc/kernel/kernel.o(.text.pmac+0xb40): undefined reference to `pmu_request'
arch/ppc/kernel/kernel.o(.text.pmac+0xb40): relocation truncated to fit: R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text.pmac+0xb50): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o(.text.pmac+0xb50): relocation truncated to fit: R_PPC_REL24 pmu_poll
arch/ppc/kernel/kernel.o: In function `nvram_write_byte':
arch/ppc/kernel/kernel.o(.text.pmac+0xc3c): undefined reference to `pmu_request'
arch/ppc/kernel/kernel.o(.text.pmac+0xc3c): relocation truncated to fit: R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text.pmac+0xc54): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o(.text.pmac+0xc54): relocation truncated to fit: R_PPC_REL24 pmu_poll
arch/ppc/kernel/kernel.o: In function `register_backlight_controller':
arch/ppc/kernel/kernel.o(.text.pmac+0xf2c): undefined reference to `pmu_request'
arch/ppc/kernel/kernel.o(.text.pmac+0xf2c): relocation truncated to fit: R_PPC_REL24 pmu_request
arch/ppc/kernel/kernel.o(.text.pmac+0xf34): undefined reference to `pmu_poll'
arch/ppc/kernel/kernel.o(.text.pmac+0xf34): relocation truncated to fit: R_PPC_REL24 pmu_poll
arch/ppc/kernel/kernel.o: In function `scrollscreen':
arch/ppc/kernel/kernel.o(.text.pmac+0x1e90): undefined reference to `pmu_suspend'
arch/ppc/kernel/kernel.o(.text.pmac+0x1e90): relocation truncated to fit: R_PPC_REL24 pmu_suspend
arch/ppc/kernel/kernel.o(.text.pmac+0x1f40): undefined reference to `pmu_resume'
arch/ppc/kernel/kernel.o(.text.pmac+0x1f40): relocation truncated to fit: R_PPC_REL24 pmu_resume
arch/ppc/kernel/kernel.o: In function `chrp_init2':
arch/ppc/kernel/kernel.o(.text.init+0x764): undefined reference to `adb_init'
arch/ppc/kernel/kernel.o(.text.init+0x764): relocation truncated to fit: R_PPC_REL24 adb_init
arch/ppc/kernel/kernel.o: In function `pmac_setup_arch':
arch/ppc/kernel/kernel.o(.text.init+0x1d34): undefined reference to `find_via_cuda'
arch/ppc/kernel/kernel.o(.text.init+0x1d34): relocation truncated to fit: R_PPC_REL24 find_via_cuda
arch/ppc/kernel/kernel.o(.text.init+0x1d38): undefined reference to `find_via_pmu'
arch/ppc/kernel/kernel.o(.text.init+0x1d38): relocation truncated to fit: R_PPC_REL24 find_via_pmu
arch/ppc/kernel/kernel.o: In function `pmac_init2':
arch/ppc/kernel/kernel.o(.text.init+0x1ee4): undefined reference to `adb_init'
arch/ppc/kernel/kernel.o(.text.init+0x1ee4): relocation truncated to fit: R_PPC_REL24 adb_init
arch/ppc/kernel/kernel.o(.text.init+0x1ee8): undefined reference to `media_bay_init'
arch/ppc/kernel/kernel.o(.text.init+0x1ee8): relocation truncated to fit: R_PPC_REL24 media_bay_init
arch/ppc/kernel/kernel.o: In function `pmac_nvram_init':
arch/ppc/kernel/kernel.o(.text.init+0x231e): undefined reference to `adb_controller'
arch/ppc/kernel/kernel.o(.text.init+0x2322): undefined reference to `adb_controller'
drivers/char/char.o: In function `misc_init':
drivers/char/char.o(.text.init+0x4a4): undefined reference to `nvram_init'
drivers/char/char.o(.text.init+0x4a4): relocation truncated to fit: R_PPC_REL24 nvram_init
drivers/char/char.o: In function `chr_dev_init':
drivers/char/char.o(.text.init+0x14d4): undefined reference to `adbdev_init'
drivers/char/char.o(.text.init+0x14d4): relocation truncated to fit: R_PPC_REL24 adbdev_init
make: *** [vmlinux] Error 1

--pWyiEgJYm5f9v55/--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
