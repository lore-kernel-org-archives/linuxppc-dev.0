Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	by ozlabs.org (Postfix) with ESMTP id 00772DE0E7
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 02:48:19 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1K9NIw-000461-9I
	for linuxppc-dev@ozlabs.org; Thu, 19 Jun 2008 11:48:16 -0500
To: linuxppc-dev@ozlabs.org
Subject: DTC 1.2.0-rc1 Tagged
Date: Thu, 19 Jun 2008 11:48:10 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1K9NIw-000461-9I@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

I've pushed out a freshly tagged DTC 1.2.0-rc1 to jdl.com.

Please feel free to test it!

Thanks,
jdl



David Gibson (34):
      libfdt: Add and use a node iteration helper function.
      libfdt: Fix NOP handling bug in fdt_add_subnode_namelen()
      dtc: Fold comment handling test into testsuite
      libfdt: More tests of NOP handling behaviour
      libfdt: Trivial cleanup for CHECK_HEADER)
      libfdt: Remove no longer used code from fdt_node_offset_by_compatible()
      dtc: Fix error reporting in push_input_file()
      dtc: Implement checks for the format of node and property names
      dtc: Fix indentation of fixup_phandle_references
      dtc: Strip redundant "name" properties
      dtc: Test and fix conversion to/from old dtb versions
      dtc: Use for_each_marker_of_type in asm_emit_data()
      dtc: Make -I dtb mode use fill_fullpaths()
      dtc: Make eval_literal() static
      dtc: Assorted improvements to test harness
      dtc: Testcases for input handling
      dtc: Make dtc_open_file() die() if unable to open requested file
      dtc: Remove ugly include stack abuse
      dtc: Abolish asize field of struct data
      dtc: Add some documentation for the dts formta
      dtc: Cleanup \nnn and \xNN string escape handling
      dtc: Change exit code for usage message
      dtc: Simplify error handling for unparseable input
      dtc: Clean up included Makefile fragments
      dtc: Trivial formatting fixes
      dtc: Make dt_from_blob() open its own input file, like the other input formats
      dtc: Rework handling of boot_cpuid_phys
      dtc: Add program to convert dts files from v0 to v1
      dtc: Remove reference to dead Makefile variables
      libfdt: Several cleanups to parameter checking
      dtc: Remove some small bashisms from test scripts
      dtc: Fix some printf() format warnings when compiling 64-bit
      dtc: Add a testcase for 'reg' or 'ranges' in /
      dtc: Add support for binary includes.

Jon Loeliger (1):
      Tag Version 1.2.0-rc1
