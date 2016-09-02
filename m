Return-Path: <fengguang.wu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sQLgT6LtQzDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2016 11:11:47 +1000 (AEST)
Date: Fri, 2 Sep 2016 09:10:58 +0800
From: kbuild test robot <lkp@intel.com>
To: Daniel Axtens <dja@axtens.net>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 3/3] powerpc/sparse: Add more assembler prototypes.
Message-ID: <201609020947.JFoLKSXl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
In-Reply-To: <1472772381-22696-3-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

[auto build test ERROR on v4.8-rc4]
[also build test ERROR on next-20160825]
[cannot apply to powerpc/next kvm-ppc/kvm-ppc-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Daniel-Axtens/powerpc-sparse-Make-a-bunch-of-things-static/20160902-075213
config: powerpc-cm5200_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/kernel/signal_32.c:47:0:
   arch/powerpc/include/asm/asm-prototypes.h:79:5: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
        unsigned long ioba, unsigned long tce);
        ^
   arch/powerpc/include/asm/asm-prototypes.h:79:5: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]
   arch/powerpc/include/asm/asm-prototypes.h:82:7: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
          unsigned long tce_list, unsigned long npages);
          ^
   arch/powerpc/include/asm/asm-prototypes.h:85:7: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
          unsigned long tce_value, unsigned long npages);
          ^
   arch/powerpc/include/asm/asm-prototypes.h:87:29: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                                unsigned int yield_count);
                                ^
   arch/powerpc/include/asm/asm-prototypes.h:88:29: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
    long kvmppc_h_random(struct kvm_vcpu *vcpu);
                                ^
   arch/powerpc/include/asm/asm-prototypes.h:90:43: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
    long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
                                              ^
   arch/powerpc/include/asm/asm-prototypes.h:95:21: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                        long pte_index, unsigned long pteh, unsigned long ptel);
                        ^
   arch/powerpc/include/asm/asm-prototypes.h:97:22: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                         unsigned long pte_index, unsigned long avpn);
                         ^
   arch/powerpc/include/asm/asm-prototypes.h:98:34: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
    long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu);
                                     ^
   arch/powerpc/include/asm/asm-prototypes.h:101:23: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                          unsigned long va);
                          ^
   arch/powerpc/include/asm/asm-prototypes.h:103:20: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                       unsigned long pte_index);
                       ^
   arch/powerpc/include/asm/asm-prototypes.h:105:25: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                            unsigned long pte_index);
                            ^
   arch/powerpc/include/asm/asm-prototypes.h:107:25: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                            unsigned long pte_index);
                            ^
   arch/powerpc/include/asm/asm-prototypes.h:109:27: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                              unsigned long slb_v, unsigned int status, bool data);
                              ^
   arch/powerpc/include/asm/asm-prototypes.h:110:39: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
    unsigned long kvmppc_rm_h_xirr(struct kvm_vcpu *vcpu);
                                          ^
   arch/powerpc/include/asm/asm-prototypes.h:112:21: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                        unsigned long mfrr);
                        ^
   arch/powerpc/include/asm/asm-prototypes.h:113:29: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
    int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
                                ^
   arch/powerpc/include/asm/asm-prototypes.h:114:28: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
    int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
                               ^
>> arch/powerpc/kernel/signal_32.c:1122:6: error: conflicting types for 'sys_swapcontext'
    long sys_swapcontext(struct ucontext __user *old_ctx,
         ^
   In file included from arch/powerpc/kernel/signal_32.c:47:0:
   arch/powerpc/include/asm/asm-prototypes.h:118:5: note: previous declaration of 'sys_swapcontext' was here
    int sys_swapcontext(struct ucontext __user *old_ctx,
        ^
   cc1: all warnings being treated as errors

vim +/sys_swapcontext +1122 arch/powerpc/kernel/signal_32.c

2b0a576d arch/powerpc/kernel/signal_32.c Michael Neuling  2013-02-13  1116  		return -EFAULT;
2b0a576d arch/powerpc/kernel/signal_32.c Michael Neuling  2013-02-13  1117  
2b0a576d arch/powerpc/kernel/signal_32.c Michael Neuling  2013-02-13  1118  	return 0;
2b0a576d arch/powerpc/kernel/signal_32.c Michael Neuling  2013-02-13  1119  }
2b0a576d arch/powerpc/kernel/signal_32.c Michael Neuling  2013-02-13  1120  #endif
2b0a576d arch/powerpc/kernel/signal_32.c Michael Neuling  2013-02-13  1121  
81e7009e arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18 @1122  long sys_swapcontext(struct ucontext __user *old_ctx,
81e7009e arch/powerpc/kernel/signal_32.c Stephen Rothwell 2005-10-18  1123  		     struct ucontext __user *new_ctx,
^1da177e arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  1124  		     int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
^1da177e arch/ppc64/kernel/signal32.c    Linus Torvalds   2005-04-16  1125  {

:::::: The code at line 1122 was first introduced by commit
:::::: 81e7009ea46c951860b8716ee427ff4f54dd26fc powerpc: merge ppc signal.c and ppc64 signal32.c

:::::: TO: Stephen Rothwell <sfr@canb.auug.org.au>
:::::: CC: Stephen Rothwell <sfr@canb.auug.org.au>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--0F1p//8PRICkK4MW
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qCNSBou+obrSgemiC+7R7z/I7+puR8EAAA==

--0F1p//8PRICkK4MW--
