Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C506B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jul 2011 14:14:55 +1000 (EST)
Subject: Re: [PATCH 4/5] powerpc: Create next_tlbcam_idx percpu variable for
	FSL_BOOKE
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <13092911313115-git-send-email-beckyb@kernel.crashing.org>
Date: Thu, 7 Jul 2011 23:13:55 -0500
Message-Id: <57D1124F-C59B-4292-9628-257C84390E6B@kernel.crashing.org>
References: <1309290888309-git-send-email-beckyb@kernel.crashing.org>
	<13092909493748-git-send-email-beckyb@kernel.crashing.org>
	<13092910103675-git-send-email-beckyb@kernel.crashing.org>
	<13092910702553-git-send-email-beckyb@kernel.crashing.org>
	<13092911313115-git-send-email-beckyb@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	wli@holomorphy.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 28, 2011, at 2:54 PM, Becky Bruce wrote:

> From: Becky Bruce <beckyb@kernel.crashing.org>
> 
> This is used to round-robin TLBCAM entries.
> 
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/mmu.h |    5 +++++
> arch/powerpc/kernel/smp.c      |    4 ++++
> arch/powerpc/mm/mem.c          |    9 +++++++++
> arch/powerpc/mm/tlb_nohash.c   |    6 ++++++
> 4 files changed, 24 insertions(+), 0 deletions(-)

applied to next

- k
