Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7B98A2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2013 01:32:20 +1000 (EST)
In-Reply-To: <1366684776-10946-2-git-send-email-hongtao.jia@freescale.com>
References: <1366684776-10946-1-git-send-email-hongtao.jia@freescale.com>
 <1366684776-10946-2-git-send-email-hongtao.jia@freescale.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CA5B8197-1A55-4E6E-AE0C-CD015D97EC83@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2 V7] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
Date: Thu, 25 Apr 2013 17:31:51 +0200
To: Jia Hongtao <hongtao.jia@freescale.com>
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> * Remove A variant of load instruction emulation

Why is this?  You handle all other simple load insns, there is
nothing special about LHA.  (I reviewed the V4 email thread, no
reason for the chance is given there).


Segher
