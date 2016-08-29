Return-Path: <fengguang.wu@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMsmq0lcSzDrgT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 10:22:49 +1000 (AEST)
Date: Mon, 29 Aug 2016 08:21:43 +0800
From: kbuild test robot <lkp@intel.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/13] perf/core: Add perf_arch_regs and mask to
 perf_regs structure
Message-ID: <201608290810.g1XYPKHG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
In-Reply-To: <1472418058-28659-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Madhavan,

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.8-rc4 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Madhavan-Srinivasan/perf-core-Add-perf_arch_regs-and-mask-to-perf_regs-structure/20160829-050443
config: s390-default_defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   security/keys/compat.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   security/keys/keyctl.o:include/linux/perf_regs.h:60: first defined here
   security/keys/compat.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   security/keys/keyctl.o:include/linux/perf_regs.h:55: first defined here
   security/keys/compat.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   security/keys/keyctl.o:include/linux/perf_regs.h:65: first defined here
--
   kernel/bpf/arraymap.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/bpf/syscall.o:include/linux/perf_regs.h:60: first defined here
   kernel/bpf/arraymap.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/bpf/syscall.o:include/linux/perf_regs.h:55: first defined here
   kernel/bpf/arraymap.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/bpf/syscall.o:include/linux/perf_regs.h:65: first defined here
   kernel/bpf/stackmap.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/bpf/syscall.o:include/linux/perf_regs.h:60: first defined here
   kernel/bpf/stackmap.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/bpf/syscall.o:include/linux/perf_regs.h:55: first defined here
   kernel/bpf/stackmap.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/bpf/syscall.o:include/linux/perf_regs.h:65: first defined here
--
   kernel/locking/rtmutex-debug.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/locking/lockdep.o:include/linux/perf_regs.h:55: first defined here
   kernel/locking/rtmutex-debug.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/locking/lockdep.o:include/linux/perf_regs.h:60: first defined here
   kernel/locking/rtmutex-debug.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/locking/lockdep.o:include/linux/perf_regs.h:65: first defined here
--
   kernel/power/process.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/power/qos.o:include/linux/perf_regs.h:60: first defined here
   kernel/power/process.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/power/qos.o:include/linux/perf_regs.h:55: first defined here
   kernel/power/process.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/power/qos.o:include/linux/perf_regs.h:65: first defined here
   kernel/power/hibernate.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/power/qos.o:include/linux/perf_regs.h:60: first defined here
   kernel/power/hibernate.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/power/qos.o:include/linux/perf_regs.h:55: first defined here
   kernel/power/hibernate.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/power/qos.o:include/linux/perf_regs.h:65: first defined here
   kernel/power/snapshot.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/power/qos.o:include/linux/perf_regs.h:60: first defined here
   kernel/power/snapshot.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/power/qos.o:include/linux/perf_regs.h:55: first defined here
   kernel/power/snapshot.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/power/qos.o:include/linux/perf_regs.h:65: first defined here
   kernel/power/user.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/power/qos.o:include/linux/perf_regs.h:60: first defined here
   kernel/power/user.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/power/qos.o:include/linux/perf_regs.h:55: first defined here
   kernel/power/user.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/power/qos.o:include/linux/perf_regs.h:65: first defined here
--
   kernel/rcu/tree.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/rcu/update.o:include/linux/perf_regs.h:60: first defined here
   kernel/rcu/tree.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/rcu/update.o:include/linux/perf_regs.h:55: first defined here
   kernel/rcu/tree.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/rcu/update.o:include/linux/perf_regs.h:65: first defined here
--
   kernel/sched/idle.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/sched/core.o:include/linux/perf_regs.h:60: first defined here
   kernel/sched/idle.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/sched/core.o:include/linux/perf_regs.h:55: first defined here
   kernel/sched/idle.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/sched/core.o:include/linux/perf_regs.h:65: first defined here
--
   kernel/time/timer.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/time/time.o:include/linux/perf_regs.h:60: first defined here
   kernel/time/timer.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/time/time.o:include/linux/perf_regs.h:55: first defined here
   kernel/time/timer.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/time/time.o:include/linux/perf_regs.h:65: first defined here
   kernel/time/hrtimer.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/time/time.o:include/linux/perf_regs.h:60: first defined here
   kernel/time/hrtimer.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/time/time.o:include/linux/perf_regs.h:55: first defined here
   kernel/time/hrtimer.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/time/time.o:include/linux/perf_regs.h:65: first defined here
   kernel/time/itimer.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/time/time.o:include/linux/perf_regs.h:60: first defined here
   kernel/time/itimer.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/time/time.o:include/linux/perf_regs.h:55: first defined here
   kernel/time/itimer.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/time/time.o:include/linux/perf_regs.h:65: first defined here
   kernel/time/posix-timers.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/time/time.o:include/linux/perf_regs.h:60: first defined here
   kernel/time/posix-timers.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/time/time.o:include/linux/perf_regs.h:55: first defined here
   kernel/time/posix-timers.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/time/time.o:include/linux/perf_regs.h:65: first defined here
   kernel/time/posix-clock.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/time/time.o:include/linux/perf_regs.h:60: first defined here
   kernel/time/posix-clock.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/time/time.o:include/linux/perf_regs.h:55: first defined here
   kernel/time/posix-clock.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/time/time.o:include/linux/perf_regs.h:65: first defined here
   kernel/time/tick-common.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/time/time.o:include/linux/perf_regs.h:60: first defined here
   kernel/time/tick-common.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/time/time.o:include/linux/perf_regs.h:55: first defined here
   kernel/time/tick-common.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/time/time.o:include/linux/perf_regs.h:65: first defined here
--
   drivers/s390/scsi/zfcp_ccw.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:60: first defined here
   drivers/s390/scsi/zfcp_ccw.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:55: first defined here
   drivers/s390/scsi/zfcp_ccw.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:65: first defined here
   drivers/s390/scsi/zfcp_dbf.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:60: first defined here
   drivers/s390/scsi/zfcp_dbf.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:55: first defined here
   drivers/s390/scsi/zfcp_dbf.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:65: first defined here
   drivers/s390/scsi/zfcp_erp.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:60: first defined here
   drivers/s390/scsi/zfcp_erp.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:55: first defined here
   drivers/s390/scsi/zfcp_erp.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:65: first defined here
   drivers/s390/scsi/zfcp_fc.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:60: first defined here
   drivers/s390/scsi/zfcp_fc.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:55: first defined here
   drivers/s390/scsi/zfcp_fc.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:65: first defined here
   drivers/s390/scsi/zfcp_fsf.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:60: first defined here
   drivers/s390/scsi/zfcp_fsf.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:55: first defined here
   drivers/s390/scsi/zfcp_fsf.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:65: first defined here
   drivers/s390/scsi/zfcp_qdio.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:60: first defined here
   drivers/s390/scsi/zfcp_qdio.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:55: first defined here
   drivers/s390/scsi/zfcp_qdio.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:65: first defined here
   drivers/s390/scsi/zfcp_scsi.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:60: first defined here
   drivers/s390/scsi/zfcp_scsi.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/s390/scsi/zfcp_aux.o:include/linux/perf_regs.h:55: first defined here
   drivers/s390/scsi/zfcp_scsi.o: In function `perf_arch_reg_value':
--
   kernel/trace/ring_buffer.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:60: first defined here
   kernel/trace/ring_buffer.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:55: first defined here
   kernel/trace/ring_buffer.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:65: first defined here
   kernel/trace/trace.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:60: first defined here
   kernel/trace/trace.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:55: first defined here
   kernel/trace/trace.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:65: first defined here
   kernel/trace/trace_output.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:60: first defined here
   kernel/trace/trace_output.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:55: first defined here
   kernel/trace/trace_output.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:65: first defined here
   kernel/trace/trace_stat.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:55: first defined here
   kernel/trace/trace_stat.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:60: first defined here
   kernel/trace/trace_stat.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:65: first defined here
   kernel/trace/trace_printk.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:60: first defined here
   kernel/trace/trace_printk.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:55: first defined here
   kernel/trace/trace_printk.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:65: first defined here
   kernel/trace/trace_sched_switch.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:55: first defined here
   kernel/trace/trace_sched_switch.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:60: first defined here
   kernel/trace/trace_sched_switch.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:65: first defined here
   kernel/trace/trace_functions.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:55: first defined here
   kernel/trace/trace_functions.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   kernel/trace/libftrace.o:include/linux/perf_regs.h:60: first defined here
   kernel/trace/trace_functions.o: In function `perf_arch_reg_value':
--
   net/core/built-in.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   net/socket.o:include/linux/perf_regs.h:60: first defined here
   net/core/built-in.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   net/socket.o:include/linux/perf_regs.h:55: first defined here
   net/core/built-in.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   net/socket.o:include/linux/perf_regs.h:65: first defined here
   net/compat.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   net/socket.o:include/linux/perf_regs.h:60: first defined here
   net/compat.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   net/socket.o:include/linux/perf_regs.h:55: first defined here
   net/compat.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   net/socket.o:include/linux/perf_regs.h:65: first defined here
--
   drivers/base/power/main.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/base/power/qos.o:include/linux/perf_regs.h:60: first defined here
   drivers/base/power/main.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/base/power/qos.o:include/linux/perf_regs.h:55: first defined here
   drivers/base/power/main.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/base/power/qos.o:include/linux/perf_regs.h:65: first defined here
   drivers/base/power/wakeup.o: In function `perf_get_arch_reg':
>> include/linux/perf_regs.h:60: multiple definition of `perf_get_arch_reg'
   drivers/base/power/qos.o:include/linux/perf_regs.h:60: first defined here
   drivers/base/power/wakeup.o: In function `perf_get_arch_regs_mask':
>> include/linux/perf_regs.h:55: multiple definition of `perf_get_arch_regs_mask'
   drivers/base/power/qos.o:include/linux/perf_regs.h:55: first defined here
   drivers/base/power/wakeup.o: In function `perf_arch_reg_value':
>> include/linux/perf_regs.h:65: multiple definition of `perf_arch_reg_value'
   drivers/base/power/qos.o:include/linux/perf_regs.h:65: first defined here
..

vim +60 include/linux/perf_regs.h

    49		regs_user->abi = perf_reg_abi(current);
    50	}
    51	
    52	u64 perf_get_arch_regs_mask(void)
    53	{
    54		return 0;
  > 55	}
    56	
    57	struct perf_arch_regs *perf_get_arch_reg(void)
    58	{
    59		return 0;
  > 60	}
    61	
    62	u64 perf_arch_reg_value(struct perf_arch_regs *regs, int idx)
    63	{
    64		return 0;
  > 65	}
    66	#endif /* CONFIG_HAVE_PERF_REGS */
    67	#endif /* _LINUX_PERF_REGS_H */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--T4sUOijqQbZv57TR
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--T4sUOijqQbZv57TR--
