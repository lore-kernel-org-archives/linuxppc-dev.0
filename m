Return-Path: <jwboyer@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.181])
	by ozlabs.org (Postfix) with ESMTP id 480A1DDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2008 06:23:29 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id o28so357620ele.3
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Oct 2008 13:23:27 -0700 (PDT)
Date: Thu, 2 Oct 2008 16:22:05 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Updated 4xx 'next' branch
Message-ID: <20081002202205.GA8748@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Victor Gallardo <vgallardo@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

I've updated my 'next' branch again.  For those that are tracking
it, you might need to force a pull as I had to rework the branch
a bit.  The following commits have been added:

Josh Boyer (3):
      ibm_newemac: Allow the "no flow control" EMAC feature to work
      ibm_newemac: Introduce mal_has_feature
      ibm_newemac: MAL support for PowerPC 405EZ

Matthias Fuchs (1):
      powerpc/4xx: Allow 4xx PCI bridge to be disabled via device tree

Victor Gallardo (4):
      ibm_newemac: Add support for GPCS, SGMII and M88E1112 PHY
      powerpc/44x: Add AMCC Arches eval board support
      powerpc/44x: Add AMCC Arches DTS
      powerpc/44x: Add AMCC Arches defconfig file

I'll let it sit for a day or so, and then ask Ben to pull.

josh
