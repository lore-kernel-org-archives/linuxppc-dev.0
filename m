Return-Path: <cel@us.ibm.com>
Subject: [Patch 0/3] OProfile SPU event profiling support for IBM Cell
	processor
From: Carl Love <cel@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 24 Nov 2008 15:19:41 -0800
Message-Id: <1227568781.6509.198.camel@carll-linux-desktop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch set consists of two kernel patches and one user level patch
to add SPU event based profiling support to OProfile for the IBM Cell
processor.  The first patch in the series is the user level patch that
adds the needed events and event checking to the user tool.  The second
patch is the first of two kernel patches.  It makes some structural
changes to the kernel code to make it easier to add the specific
functions for doing SPU event profiling.  The first kernel patch does
not make any functional changes.  The third patch in the series is the
second kernel patch where the actual SPU event profiling code support is
added to the kernel.

          Carl Love
