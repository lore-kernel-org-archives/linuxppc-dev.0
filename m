Return-Path: <anton@samba.org>
Message-Id: <20110725023311.175792493@samba.org>
Date: Mon, 25 Jul 2011 12:33:11 +1000
From: Anton Blanchard <anton@samba.org>
To: mingo@elte.hu,
 peterz@infradead.org,
 benh@kernel.crashing.org
Subject: [PATCH 0/5] ppc64 scheduler fixes
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are a set of ppc64 scheduler fixes that help with some
multi node performance issues.
