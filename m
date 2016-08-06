Return-Path: <fengguang.wu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s5qV82RkszDqTy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Aug 2016 13:51:27 +1000 (AEST)
Date: Sat, 6 Aug 2016 11:50:53 +0800
From: kbuild test robot <lkp@intel.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kbuild-all@01.org, linux-kbuild@vger.kernel.org,
 linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>,
 Alan Modra <amodra@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Message-ID: <201608061132.dqWg7HVU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1470399123-8455-2-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

[auto build test ERROR on kbuild/for-next]
[also build test ERROR on v4.7]
[cannot apply to linus/master linux/master next-20160805]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/kbuild-changes-thin-archives-gc-sections/20160805-202258
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmarek/kbuild.git for-next
config: um-allnoconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um 

All errors (new ones prefixed by >>):

   init/built-in.o:(.bss+0x4): multiple definition of `reset_devices'
   init/built-in.o:(.bss+0x4): first defined here
   init/built-in.o: In function `prepare_namespace':
   (.init.text+0x988): multiple definition of `prepare_namespace'
   init/built-in.o:(.init.text+0x988): first defined here
   init/built-in.o:(.init.data+0x1070): multiple definition of `late_time_init'
   init/built-in.o:(.init.data+0x1070): first defined here
   init/built-in.o: In function `load_default_modules':
   (.init.text+0x2f8): multiple definition of `load_default_modules'
   init/built-in.o:(.init.text+0x2f8): first defined here
   init/built-in.o:(.bss+0x10): multiple definition of `system_state'
   init/built-in.o:(.bss+0x10): first defined here
   init/built-in.o: In function `mount_root':
   (.init.text+0x987): multiple definition of `mount_root'
   init/built-in.o:(.init.text+0x987): first defined here
   init/built-in.o: In function `mount_block_root':
   (.init.text+0x836): multiple definition of `mount_block_root'
   init/built-in.o:(.init.text+0x836): first defined here
   init/built-in.o:(.bss+0x14): multiple definition of `early_boot_irqs_disabled'
   init/built-in.o:(.bss+0x14): first defined here
   init/built-in.o:(.data+0x0): multiple definition of `loops_per_jiffy'
   init/built-in.o:(.data+0x0): first defined here
   init/built-in.o:(.bss+0xc): multiple definition of `saved_command_line'
   init/built-in.o:(.bss+0xc): first defined here
   init/built-in.o: In function `calibrate_delay':
   (.text+0x2e0): multiple definition of `calibrate_delay'
   init/built-in.o:(.text+0x2e0): first defined here
   init/built-in.o: In function `do_one_initcall':
   (.init.text+0x57a): multiple definition of `do_one_initcall'
   init/built-in.o:(.init.text+0x57a): first defined here
   init/built-in.o:(.rodata+0x20): multiple definition of `linux_proc_banner'
   init/built-in.o:(.rodata+0x20): first defined here
   init/built-in.o:(.init.data+0x20e4): multiple definition of `rd_doload'
   init/built-in.o:(.init.data+0x20e4): first defined here
   init/built-in.o:(.data+0x620): multiple definition of `init_task'
   init/built-in.o:(.data+0x620): first defined here
   init/built-in.o:(.data+0x460): multiple definition of `init_uts_ns'
   init/built-in.o:(.data+0x460): first defined here
   init/built-in.o:(.data+0x20): multiple definition of `envp_init'
   init/built-in.o:(.data+0x20): first defined here
   init/built-in.o: In function `name_to_dev_t':
   (.text+0x70): multiple definition of `name_to_dev_t'
   init/built-in.o:(.text+0x70): first defined here
   init/built-in.o:(.data+0x618): multiple definition of `root_mountflags'
   init/built-in.o:(.data+0x618): first defined here
   init/built-in.o:(.bss+0x8): multiple definition of `static_key_initialized'
   init/built-in.o:(.bss+0x8): first defined here
   init/built-in.o: In function `start_kernel':
   (.init.text+0x351): multiple definition of `start_kernel'
   init/built-in.o:(.init.text+0x351): first defined here
>> init/built-in.o:(.bss+0x30): multiple definition of `Version_263936'
   init/built-in.o:(.bss+0x30): first defined here
   init/built-in.o: In function `parse_early_options':
   (.init.text+0x2f9): multiple definition of `parse_early_options'
   init/built-in.o:(.init.text+0x2f9): first defined here
   init/built-in.o: In function `parse_early_param':
   (.init.text+0x31a): multiple definition of `parse_early_param'
   init/built-in.o:(.init.text+0x31a): first defined here
   init/built-in.o:(.bss+0x40): multiple definition of `preset_lpj'
   init/built-in.o:(.bss+0x40): first defined here
   init/built-in.o:(.data..init_task+0x0): multiple definition of `init_thread_union'
   init/built-in.o:(.data..init_task+0x0): first defined here
   init/built-in.o: In function `init_rootfs':
   (.init.text+0x80a): multiple definition of `init_rootfs'
   init/built-in.o:(.init.text+0x80a): first defined here
   init/built-in.o:(.rodata+0x80): multiple definition of `linux_banner'
   init/built-in.o:(.rodata+0x80): first defined here
   init/built-in.o:(.bss+0x34): multiple definition of `ROOT_DEV'
   init/built-in.o:(.bss+0x34): first defined here
   init/built-in.o:(.bss+0x0): multiple definition of `initcall_debug'
   init/built-in.o:(.bss+0x0): first defined here
   init/built-in.o:(.init.data+0x1080): multiple definition of `boot_command_line'
   init/built-in.o:(.init.data+0x1080): first defined here
   init/built-in.o:(.bss+0x44): multiple definition of `lpj_fine'
   init/built-in.o:(.bss+0x44): first defined here
   collect2: error: ld returned 1 exit status

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--azLHFNyN32YCQGCU
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
f7Tt28O9MwAA

--azLHFNyN32YCQGCU--
