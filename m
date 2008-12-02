Return-Path: <cel@us.ibm.com>
Subject: [Patch 0/3] Overview, OProfile SPU event profiling support for IBM
	Cell processor
From: Carl Love <cel@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, cel <cel@linux.vnet.ibm.com>,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 16:18:26 -0800
Message-Id: <1228177106.6509.285.camel@carll-linux-desktop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a rework of the previously posted set of patches.

Patch 1 is the user level patch to add the SPU events to the user
OProfile tool.  

Patch 2 is a kernel patch to do code clean up and restructuring to make
it easier to add the new SPU event profiling support.  This patch makes
no functional changes.

Patch 3 is a kernel patch to add the SPU event profiling support.

               Carl Love
