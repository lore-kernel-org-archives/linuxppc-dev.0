Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8BAFAB6F65
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Aug 2011 05:29:05 +1000 (EST)
Date: Mon, 22 Aug 2011 12:28:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] RapidIO: Fix use of non-compatible registers
Message-Id: <20110822122807.5b558d65.akpm@linux-foundation.org>
In-Reply-To: <1311703646-3453-1-git-send-email-alexandre.bounine@idt.com>
References: <1311703646-3453-1-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Chul Kim <chul.kim@idt.com>, linux-kernel@vger.kernel.org,
	Thomas Moll <thomas.moll@sysgo.com>,
	linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jul 2011 14:07:26 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Replace/remove use of RIO v.1.2 registers/bits that are not forward-compatible
> with newer versions of RapidIO specification.
> 
> RapidIO specification v. 1.3 removed Write Port CSR, Doorbell CSR,
> Mailbox CSR and Mailbox and Doorbell bits of the PEF CAR.
> 
> Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: Matt Porter <mporter@kernel.crashing.org>
> Cc: Li Yang <leoli@freescale.com>
> Cc: Thomas Moll <thomas.moll@sysgo.com>
> Cc: Chul Kim <chul.kim@idt.com>
> Cc: <stable@kernel.org>

You did a cc:stable but provided no reason (that I can understand) for
backporting the patch.  Please explain why the problem is sufficiently
serious to warrant this action.
