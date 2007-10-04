Return-Path: <benh@ozlabs.org>
To: <bluesmoke-devel@lists.sourceforge.net>,
	<linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 04 Oct 2007 15:40:42 +1000
Subject: [PATCH 0/4] Cell EDAC driver and dependencies
Message-Id: <1191476442.154524.519055590678.qpush@grosgo>
Cc: Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a serie of 4 patches. The first two should be applied via
the powerpc tree and the second via the bluesmoke tree. The later
do depend on the former so the new driver won't compile until the
former has been merged in case bluesmoke is pulled first but that
shoudn't be a big issue.
