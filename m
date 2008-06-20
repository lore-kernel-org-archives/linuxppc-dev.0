Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 20 Jun 2008 14:13:52 +1000
Subject: [PATCH 0/9] powerpc: Add kernel support for POWER7 VSX. 
In-Reply-To: <1213750053.678227.22239172650.qpush@coopers>
Message-Id: <1213935232.194904.168421502953.qpush@coopers>
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

Updated with comments from Kumar, Milton, Dave Woodhouse and Mark
'NKOTB' Nelson.
- Changed thread_struct array definition to be cleaner
- Updated CPU_FTRS_POSSIBLE 
- Updated Kconfig typo and dupilicate
- Added comment to clarify ibm,vmx = 2 really means VSX. 
