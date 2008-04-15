Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEF30DF306
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 09:21:35 +1000 (EST)
Message-Id: <E8DF8116-CAE0-40E5-824C-4BFD01C4379F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <d4df2c06535af05ef2cd80c0dd053b1d200f6993.1208296521.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 3/3] powerpc: Add defconfig for Wind River SBC8641D board
Date: Tue, 15 Apr 2008 18:21:31 -0500
References: <1208299292-21937-1-git-send-email-paul.gortmaker@windriver.com>
	<96011ba20ab9319aa866c12e2ff91ad579d26aed.1208296521.git.paul.gortmaker@windriver.com>
	<c3840b6d7622db88a748213c806c6cfe4bf404ef.1208296521.git.paul.gortmaker@windriver.com>
	<d4df2c06535af05ef2cd80c0dd053b1d200f6993.1208296521.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 15, 2008, at 5:41 PM, Paul Gortmaker wrote:
> This adds a sample defconfig for the Wind River SBC8641D
> board, with SMP, PCI and NFS root enabled.
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/configs/sbc8641d_defconfig | 1342 ++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 1342 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/configs/sbc8641d_defconfig

applied.

- k
