Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 975DDDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 00:08:12 +1100 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1JdPvk-0005mf-2k
	for linuxppc-dev@ozlabs.org; Sun, 23 Mar 2008 08:08:08 -0500
To: linuxppc-dev@ozlabs.org
Subject: DTC Patch Catch Up
Date: Sun, 23 Mar 2008 08:08:08 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JdPvk-0005mf-2k@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Folks,

I've applied the following patches from Gibson,
in this order, to the DTC and pushed it out
to git.jdl.com:

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

Thanks,
jdl
