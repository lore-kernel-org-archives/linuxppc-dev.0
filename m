Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 8AF3EB7121
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Jan 2011 20:52:44 +1100 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Pass the right cpu_spec to ->setup_cpu() on
	64-bit
References: <1295591763.2148.282.camel__24783.9240976193$1295591799$gmane$org@pasglop>
Date: Fri, 21 Jan 2011 10:52:40 +0100
In-Reply-To: <1295591763.2148.282.camel__24783.9240976193$1295591799$gmane$org@pasglop>
	(Benjamin Herrenschmidt's message of "Fri, 21 Jan 2011 17:36:03
	+1100")
Message-ID: <m3wrly4m8n.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

You may also want to remove the misleading sentence about PTRRELOC in
the preceding comment, since both s and t were already passed through it
anyway.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
