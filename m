Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4B611B6F81
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 21:33:07 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v3] booke/kprobe: Fix stack corrupt issue when kprobe 'stwu'
Date: Mon, 11 Jul 2011 19:31:55 +0800
Message-ID: <1310383915-30543-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v1 -> v2: when allocate pgirq_ctx, use 'hw_cpu' to identify cpu ID in exc_lvl_early_init().
v2 -> v3: add that specific return-from-program-exc to restore necessary thread info then
we can withdraw the original patch #2.

Tiejun
