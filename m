Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EC27EB71A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 05:00:21 +1100 (EST)
Message-ID: <4E9332AA.1050307@freescale.com>
Date: Mon, 10 Oct 2011 13:00:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: Re: [PATCH 2/3] [44x] Enable CONFIG_RELOCATABLE for PPC44x
References: <20111010094627.16589.52367.stgit@suzukikp.in.ibm.com>
 <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20111010095514.16589.85241.stgit@suzukikp.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Michal Simek <monstr@monstr.eu>, tmarri@apm.com,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Dave Hansen <dave@linux.vnet.ibm.com>, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>,
 linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/10/2011 04:56 AM, Suzuki K. Poulose wrote:
> #if defined(CONFIG_RELOCATABLE) && defined(CONFIG_44x)
> #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) - PHYSICAL_START + (KERNELBASE + RELOC_OFFSET)))
> #define __pa(x) ((unsigned long)(x) + PHYSICAL_START - (KERNELBASE + RELOC_OFFSET))
> #endif

Why is this 44x-specific?

-Scott
