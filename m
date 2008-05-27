Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee [193.40.5.67])
	by ozlabs.org (Postfix) with ESMTP id 794B8DE0E4
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 03:25:46 +1000 (EST)
Date: Tue, 27 May 2008 20:25:43 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Subject: PPC PReP link failure - copy_page, empty_zero_page
Message-ID: <Pine.SOC.4.64.0805272022260.869@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While compiling the current kernel on prep ppc:

  MODPOST 703 modules
ERROR: "copy_page" [fs/fuse/fuse.ko] undefined!
ERROR: "empty_zero_page" [fs/ext4/ext4dev.ko] undefined!

-- 
Meelis Roos (mroos@linux.ee)
