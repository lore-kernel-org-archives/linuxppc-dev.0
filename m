Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 850F9B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 07:49:55 +1100 (EST)
Subject: Re: [PATCH -mm] RapidIO,powerpc/85xx: Fix configuration option
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1300468735-1158-1-git-send-email-alexandre.bounine@idt.com>
Date: Fri, 18 Mar 2011 15:49:00 -0500
Message-Id: <8E8332C6-1F17-4EC1-BD04-7B93D7B49640@kernel.crashing.org>
References: <1300468735-1158-1-git-send-email-alexandre.bounine@idt.com>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 18, 2011, at 12:18 PM, Alexandre Bounine wrote:

> Follows set of patches in -mm tree. Replaces configuration option
> missed in previous patches.
> 
> Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
> ---
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Kumar Gala <galak@kernel.crashing.org>

Alex, I can push this via the powerpc.git tree route if you want.

- k
