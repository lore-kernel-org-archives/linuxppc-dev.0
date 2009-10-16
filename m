Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0E46B8224
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Oct 2009 04:22:47 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add a Book-3E 64-bit defconfig
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1255712717-21221-1-git-send-email-galak@kernel.crashing.org>
Date: Fri, 16 Oct 2009 12:22:26 -0500
Message-Id: <A136CC2D-DAEF-40FB-A4D2-E2C1EBFE9034@kernel.crashing.org>
References: <1255712717-21221-1-git-send-email-galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 16, 2009, at 12:05 PM, Kumar Gala wrote:

> This defconfig's purpose at this time is to help catch compile errors
> between Book-3S and Book-3E support in ppc64.  It is based on the
> ppc64_defconfig with some things disabled that we dont support on
> Book-3E right now (hugetlbfs, slices, etc.)
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/configs/ppc64e_defconfig | 2199 ++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 2199 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/configs/ppc64e_defconfig

Ben,

Please apply this for v2.6.32 as it should help going forward catching  
compile issues.

Stephen, Michaeal,

Can we get this added to the build testing for next and to kisskb.

thanks.

- k
