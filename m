Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Wed, 25 Jun 2008 14:07:17 +1000
Subject: [PATCH 0/9] powerpc: Add kernel support for POWER7 VSX. 
In-Reply-To: <1214305069.538931.136638600960.qpush@coopers>
Message-Id: <1214366837.623950.515350956858.qpush@coopers>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following set of patches adds Vector Scalar Extentions (VSX)
support for POWER7.  Includes context switch, ptrace and signals support.

Signed-off-by: Michael Neuling <mikey@neuling.org>
--- 
Paulus: please consider for your 2.6.27 tree.

Updates this post....
- White space change in start_thread thanks to Paulus
- thread_struct change/cleanup suggested thanks to Paulus. This
  also resulted in changing TS_FPRSPACING to TS_FPRWIDTH
- pointer to array fix, thanks to Kumar
- indexing macro fix in ptrace32 thanks to Kumar
- moved SAVE/REST_32FPVSRS to where they are used in fpu.S suggested by Kumar

This time for sure!
