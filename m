Return-Path: <cel@us.ibm.com>
Subject: [PATCH 0/2] Cell OProfile: SPU mutex lock fix, version 4
From: Carl Love <cel@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 01 Aug 2008 13:01:14 -0700
Message-Id: <1217620874.15667.141.camel@carll-linux-desktop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Patch 1 is version 4 of the SPU mutex lock fix.

Patch 2 is a patch to fix an issue found in OProfile while implementing
version 4 of the SPU mutex lock fix.
