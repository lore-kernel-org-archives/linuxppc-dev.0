Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C0C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:59:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA56E2077C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 16:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA56E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VgKs6RH4zF33c
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 03:58:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=intel.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VgGR0Ht8zF1WK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:55:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=intel.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42VgGQ5k6nz8tKp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 03:55:58 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42VgGQ5S7Gz9sCV; Thu, 11 Oct 2018 03:55:58 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=intel.com
 (client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=lkp@intel.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42VgGP1FQ7z9sC7
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2018 03:55:55 +1100 (AEDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2018 09:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,365,1534834800"; 
 d="gz'50?scan'50,208,50";a="240216565"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
 by orsmga004.jf.intel.com with ESMTP; 10 Oct 2018 09:55:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
 (envelope-from <lkp@intel.com>)
 id 1gAHlu-000CvB-2S; Thu, 11 Oct 2018 00:55:42 +0800
Date: Thu, 11 Oct 2018 00:55:33 +0800
From: kbuild test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 4/4] powerpc: Add -Wimplicit-fallthrough to arch CFLAGS
Message-ID: <201810110000.PrLAfI3c%fengguang.wu@intel.com>
References: <20181010051308.25422-4-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <20181010051308.25422-4-mpe@ellerman.id.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, maddy@linux.ibm.com, kbuild-all@01.org,
 keescook@chromium.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.19-rc7 next-20181010]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michael-Ellerman/powerpc-Move-core-kernel-logic-into-arch-powerpc-Kbuild/20181010-205834
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-socrates_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/align.c: In function 'emulate_spe':
>> arch/powerpc/kernel/align.c:183:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
       ret |= __get_user_inatomic(temp.v[3], p++);
           ^~
   arch/powerpc/kernel/align.c:184:3: note: here
      case 4:
      ^~~~
   arch/powerpc/kernel/align.c:186:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
       ret |= __get_user_inatomic(temp.v[5], p++);
           ^~
   arch/powerpc/kernel/align.c:187:3: note: here
      case 2:
      ^~~~
   arch/powerpc/kernel/align.c:266:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
       ret |= __put_user_inatomic(data.v[3], p++);
           ^~
   arch/powerpc/kernel/align.c:267:3: note: here
      case 4:
      ^~~~
   arch/powerpc/kernel/align.c:269:8: error: this statement may fall through [-Werror=implicit-fallthrough=]
       ret |= __put_user_inatomic(data.v[5], p++);
           ^~
   arch/powerpc/kernel/align.c:270:3: note: here
      case 2:
      ^~~~
   cc1: all warnings being treated as errors

vim +183 arch/powerpc/kernel/align.c

26caeb2e Kumar Gala             2007-08-24  104  
26caeb2e Kumar Gala             2007-08-24  105  /*
26caeb2e Kumar Gala             2007-08-24  106   * Emulate SPE loads and stores.
26caeb2e Kumar Gala             2007-08-24  107   * Only Book-E has these instructions, and it does true little-endian,
26caeb2e Kumar Gala             2007-08-24  108   * so we don't need the address swizzling.
26caeb2e Kumar Gala             2007-08-24  109   */
26caeb2e Kumar Gala             2007-08-24  110  static int emulate_spe(struct pt_regs *regs, unsigned int reg,
26caeb2e Kumar Gala             2007-08-24  111  		       unsigned int instr)
26caeb2e Kumar Gala             2007-08-24  112  {
f626190d Anton Blanchard        2013-09-23  113  	int ret;
26caeb2e Kumar Gala             2007-08-24  114  	union {
26caeb2e Kumar Gala             2007-08-24  115  		u64 ll;
26caeb2e Kumar Gala             2007-08-24  116  		u32 w[2];
26caeb2e Kumar Gala             2007-08-24  117  		u16 h[4];
26caeb2e Kumar Gala             2007-08-24  118  		u8 v[8];
26caeb2e Kumar Gala             2007-08-24  119  	} data, temp;
26caeb2e Kumar Gala             2007-08-24  120  	unsigned char __user *p, *addr;
26caeb2e Kumar Gala             2007-08-24  121  	unsigned long *evr = &current->thread.evr[reg];
26caeb2e Kumar Gala             2007-08-24  122  	unsigned int nb, flags;
26caeb2e Kumar Gala             2007-08-24  123  
26caeb2e Kumar Gala             2007-08-24  124  	instr = (instr >> 1) & 0x1f;
26caeb2e Kumar Gala             2007-08-24  125  
26caeb2e Kumar Gala             2007-08-24  126  	/* DAR has the operand effective address */
26caeb2e Kumar Gala             2007-08-24  127  	addr = (unsigned char __user *)regs->dar;
26caeb2e Kumar Gala             2007-08-24  128  
26caeb2e Kumar Gala             2007-08-24  129  	nb = spe_aligninfo[instr].len;
26caeb2e Kumar Gala             2007-08-24  130  	flags = spe_aligninfo[instr].flags;
26caeb2e Kumar Gala             2007-08-24  131  
26caeb2e Kumar Gala             2007-08-24  132  	/* Verify the address of the operand */
26caeb2e Kumar Gala             2007-08-24  133  	if (unlikely(user_mode(regs) &&
26caeb2e Kumar Gala             2007-08-24  134  		     !access_ok((flags & ST ? VERIFY_WRITE : VERIFY_READ),
26caeb2e Kumar Gala             2007-08-24  135  				addr, nb)))
26caeb2e Kumar Gala             2007-08-24  136  		return -EFAULT;
26caeb2e Kumar Gala             2007-08-24  137  
26caeb2e Kumar Gala             2007-08-24  138  	/* userland only */
26caeb2e Kumar Gala             2007-08-24  139  	if (unlikely(!user_mode(regs)))
26caeb2e Kumar Gala             2007-08-24  140  		return 0;
26caeb2e Kumar Gala             2007-08-24  141  
26caeb2e Kumar Gala             2007-08-24  142  	flush_spe_to_thread(current);
26caeb2e Kumar Gala             2007-08-24  143  
26caeb2e Kumar Gala             2007-08-24  144  	/* If we are loading, get the data from user space, else
26caeb2e Kumar Gala             2007-08-24  145  	 * get it from register values
26caeb2e Kumar Gala             2007-08-24  146  	 */
26caeb2e Kumar Gala             2007-08-24  147  	if (flags & ST) {
26caeb2e Kumar Gala             2007-08-24  148  		data.ll = 0;
26caeb2e Kumar Gala             2007-08-24  149  		switch (instr) {
26caeb2e Kumar Gala             2007-08-24  150  		case EVSTDD:
26caeb2e Kumar Gala             2007-08-24  151  		case EVSTDW:
26caeb2e Kumar Gala             2007-08-24  152  		case EVSTDH:
26caeb2e Kumar Gala             2007-08-24  153  			data.w[0] = *evr;
26caeb2e Kumar Gala             2007-08-24  154  			data.w[1] = regs->gpr[reg];
26caeb2e Kumar Gala             2007-08-24  155  			break;
26caeb2e Kumar Gala             2007-08-24  156  		case EVSTWHE:
26caeb2e Kumar Gala             2007-08-24  157  			data.h[2] = *evr >> 16;
26caeb2e Kumar Gala             2007-08-24  158  			data.h[3] = regs->gpr[reg] >> 16;
26caeb2e Kumar Gala             2007-08-24  159  			break;
26caeb2e Kumar Gala             2007-08-24  160  		case EVSTWHO:
26caeb2e Kumar Gala             2007-08-24  161  			data.h[2] = *evr & 0xffff;
26caeb2e Kumar Gala             2007-08-24  162  			data.h[3] = regs->gpr[reg] & 0xffff;
26caeb2e Kumar Gala             2007-08-24  163  			break;
26caeb2e Kumar Gala             2007-08-24  164  		case EVSTWWE:
26caeb2e Kumar Gala             2007-08-24  165  			data.w[1] = *evr;
26caeb2e Kumar Gala             2007-08-24  166  			break;
26caeb2e Kumar Gala             2007-08-24  167  		case EVSTWWO:
26caeb2e Kumar Gala             2007-08-24  168  			data.w[1] = regs->gpr[reg];
26caeb2e Kumar Gala             2007-08-24  169  			break;
26caeb2e Kumar Gala             2007-08-24  170  		default:
26caeb2e Kumar Gala             2007-08-24  171  			return -EINVAL;
26caeb2e Kumar Gala             2007-08-24  172  		}
26caeb2e Kumar Gala             2007-08-24  173  	} else {
26caeb2e Kumar Gala             2007-08-24  174  		temp.ll = data.ll = 0;
26caeb2e Kumar Gala             2007-08-24  175  		ret = 0;
26caeb2e Kumar Gala             2007-08-24  176  		p = addr;
26caeb2e Kumar Gala             2007-08-24  177  
26caeb2e Kumar Gala             2007-08-24  178  		switch (nb) {
26caeb2e Kumar Gala             2007-08-24  179  		case 8:
26caeb2e Kumar Gala             2007-08-24  180  			ret |= __get_user_inatomic(temp.v[0], p++);
26caeb2e Kumar Gala             2007-08-24  181  			ret |= __get_user_inatomic(temp.v[1], p++);
26caeb2e Kumar Gala             2007-08-24  182  			ret |= __get_user_inatomic(temp.v[2], p++);
26caeb2e Kumar Gala             2007-08-24 @183  			ret |= __get_user_inatomic(temp.v[3], p++);
26caeb2e Kumar Gala             2007-08-24  184  		case 4:
26caeb2e Kumar Gala             2007-08-24  185  			ret |= __get_user_inatomic(temp.v[4], p++);
26caeb2e Kumar Gala             2007-08-24  186  			ret |= __get_user_inatomic(temp.v[5], p++);
26caeb2e Kumar Gala             2007-08-24  187  		case 2:
26caeb2e Kumar Gala             2007-08-24  188  			ret |= __get_user_inatomic(temp.v[6], p++);
26caeb2e Kumar Gala             2007-08-24  189  			ret |= __get_user_inatomic(temp.v[7], p++);
26caeb2e Kumar Gala             2007-08-24  190  			if (unlikely(ret))
26caeb2e Kumar Gala             2007-08-24  191  				return -EFAULT;
26caeb2e Kumar Gala             2007-08-24  192  		}
26caeb2e Kumar Gala             2007-08-24  193  
26caeb2e Kumar Gala             2007-08-24  194  		switch (instr) {
26caeb2e Kumar Gala             2007-08-24  195  		case EVLDD:
26caeb2e Kumar Gala             2007-08-24  196  		case EVLDW:
26caeb2e Kumar Gala             2007-08-24  197  		case EVLDH:
26caeb2e Kumar Gala             2007-08-24  198  			data.ll = temp.ll;
26caeb2e Kumar Gala             2007-08-24  199  			break;
26caeb2e Kumar Gala             2007-08-24  200  		case EVLHHESPLAT:
26caeb2e Kumar Gala             2007-08-24  201  			data.h[0] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  202  			data.h[2] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  203  			break;
26caeb2e Kumar Gala             2007-08-24  204  		case EVLHHOUSPLAT:
26caeb2e Kumar Gala             2007-08-24  205  		case EVLHHOSSPLAT:
26caeb2e Kumar Gala             2007-08-24  206  			data.h[1] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  207  			data.h[3] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  208  			break;
26caeb2e Kumar Gala             2007-08-24  209  		case EVLWHE:
26caeb2e Kumar Gala             2007-08-24  210  			data.h[0] = temp.h[2];
26caeb2e Kumar Gala             2007-08-24  211  			data.h[2] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  212  			break;
26caeb2e Kumar Gala             2007-08-24  213  		case EVLWHOU:
26caeb2e Kumar Gala             2007-08-24  214  		case EVLWHOS:
26caeb2e Kumar Gala             2007-08-24  215  			data.h[1] = temp.h[2];
26caeb2e Kumar Gala             2007-08-24  216  			data.h[3] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  217  			break;
26caeb2e Kumar Gala             2007-08-24  218  		case EVLWWSPLAT:
26caeb2e Kumar Gala             2007-08-24  219  			data.w[0] = temp.w[1];
26caeb2e Kumar Gala             2007-08-24  220  			data.w[1] = temp.w[1];
26caeb2e Kumar Gala             2007-08-24  221  			break;
26caeb2e Kumar Gala             2007-08-24  222  		case EVLWHSPLAT:
26caeb2e Kumar Gala             2007-08-24  223  			data.h[0] = temp.h[2];
26caeb2e Kumar Gala             2007-08-24  224  			data.h[1] = temp.h[2];
26caeb2e Kumar Gala             2007-08-24  225  			data.h[2] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  226  			data.h[3] = temp.h[3];
26caeb2e Kumar Gala             2007-08-24  227  			break;
26caeb2e Kumar Gala             2007-08-24  228  		default:
26caeb2e Kumar Gala             2007-08-24  229  			return -EINVAL;
26caeb2e Kumar Gala             2007-08-24  230  		}
26caeb2e Kumar Gala             2007-08-24  231  	}
26caeb2e Kumar Gala             2007-08-24  232  
26caeb2e Kumar Gala             2007-08-24  233  	if (flags & SW) {
26caeb2e Kumar Gala             2007-08-24  234  		switch (flags & 0xf0) {
26caeb2e Kumar Gala             2007-08-24  235  		case E8:
f626190d Anton Blanchard        2013-09-23  236  			data.ll = swab64(data.ll);
26caeb2e Kumar Gala             2007-08-24  237  			break;
26caeb2e Kumar Gala             2007-08-24  238  		case E4:
f626190d Anton Blanchard        2013-09-23  239  			data.w[0] = swab32(data.w[0]);
f626190d Anton Blanchard        2013-09-23  240  			data.w[1] = swab32(data.w[1]);
26caeb2e Kumar Gala             2007-08-24  241  			break;
26caeb2e Kumar Gala             2007-08-24  242  		/* Its half word endian */
26caeb2e Kumar Gala             2007-08-24  243  		default:
f626190d Anton Blanchard        2013-09-23  244  			data.h[0] = swab16(data.h[0]);
f626190d Anton Blanchard        2013-09-23  245  			data.h[1] = swab16(data.h[1]);
f626190d Anton Blanchard        2013-09-23  246  			data.h[2] = swab16(data.h[2]);
f626190d Anton Blanchard        2013-09-23  247  			data.h[3] = swab16(data.h[3]);
26caeb2e Kumar Gala             2007-08-24  248  			break;
26caeb2e Kumar Gala             2007-08-24  249  		}
26caeb2e Kumar Gala             2007-08-24  250  	}
26caeb2e Kumar Gala             2007-08-24  251  
26caeb2e Kumar Gala             2007-08-24  252  	if (flags & SE) {
26caeb2e Kumar Gala             2007-08-24  253  		data.w[0] = (s16)data.h[1];
26caeb2e Kumar Gala             2007-08-24  254  		data.w[1] = (s16)data.h[3];
26caeb2e Kumar Gala             2007-08-24  255  	}
26caeb2e Kumar Gala             2007-08-24  256  
26caeb2e Kumar Gala             2007-08-24  257  	/* Store result to memory or update registers */
26caeb2e Kumar Gala             2007-08-24  258  	if (flags & ST) {
26caeb2e Kumar Gala             2007-08-24  259  		ret = 0;
26caeb2e Kumar Gala             2007-08-24  260  		p = addr;
26caeb2e Kumar Gala             2007-08-24  261  		switch (nb) {
26caeb2e Kumar Gala             2007-08-24  262  		case 8:
26caeb2e Kumar Gala             2007-08-24  263  			ret |= __put_user_inatomic(data.v[0], p++);
26caeb2e Kumar Gala             2007-08-24  264  			ret |= __put_user_inatomic(data.v[1], p++);
26caeb2e Kumar Gala             2007-08-24  265  			ret |= __put_user_inatomic(data.v[2], p++);
26caeb2e Kumar Gala             2007-08-24  266  			ret |= __put_user_inatomic(data.v[3], p++);
26caeb2e Kumar Gala             2007-08-24  267  		case 4:
26caeb2e Kumar Gala             2007-08-24  268  			ret |= __put_user_inatomic(data.v[4], p++);
26caeb2e Kumar Gala             2007-08-24  269  			ret |= __put_user_inatomic(data.v[5], p++);
26caeb2e Kumar Gala             2007-08-24  270  		case 2:
26caeb2e Kumar Gala             2007-08-24  271  			ret |= __put_user_inatomic(data.v[6], p++);
26caeb2e Kumar Gala             2007-08-24  272  			ret |= __put_user_inatomic(data.v[7], p++);
26caeb2e Kumar Gala             2007-08-24  273  		}
26caeb2e Kumar Gala             2007-08-24  274  		if (unlikely(ret))
26caeb2e Kumar Gala             2007-08-24  275  			return -EFAULT;
26caeb2e Kumar Gala             2007-08-24  276  	} else {
26caeb2e Kumar Gala             2007-08-24  277  		*evr = data.w[0];
26caeb2e Kumar Gala             2007-08-24  278  		regs->gpr[reg] = data.w[1];
26caeb2e Kumar Gala             2007-08-24  279  	}
26caeb2e Kumar Gala             2007-08-24  280  
26caeb2e Kumar Gala             2007-08-24  281  	return 1;
26caeb2e Kumar Gala             2007-08-24  282  }
26caeb2e Kumar Gala             2007-08-24  283  #endif /* CONFIG_SPE */
5daf9071 Benjamin Herrenschmidt 2005-11-18  284  

:::::: The code at line 183 was first introduced by commit
:::::: 26caeb2ee1924d564e8d8190aa783a569532f81a [POWERPC] Handle alignment faults on SPE load/store instructions

:::::: TO: Kumar Gala <galak@kernel.crashing.org>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o--
