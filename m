Return-Path: <arnd@arndb.de>
Message-Id: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Fri, 07 Apr 2006 17:01:24 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/5] cell: recent bug fixes
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This set of patches is mostly about making it possible to use
64k pages on the Cell platform, which did not work because
of a number of bugs.

Paulus, please apply to your bugfix tree.

	Arnd <><
