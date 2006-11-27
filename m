Return-Path: <arnd@arndb.de>
Message-Id: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:51 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 0/9] cell bug fixes for 2.6.20
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This seems to be the fallout of merging so many large patches in the
recent times, mostly stuff broke by combining recent features.

If everyone likes these patches, please pull them from
kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6.git cell-merge

	Arnd <><
--
