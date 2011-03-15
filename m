Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44B73B7010
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 02:51:37 +1100 (EST)
Subject: Re: [PATCH] Fix SPE float to integer conversion failure
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1289960933-5172-2-git-send-email-shan.hai@windriver.com>
Date: Tue, 15 Mar 2011 10:51:31 -0500
Message-Id: <B94B10A4-195E-496E-8821-64F60D7FB97F@kernel.crashing.org>
References: <1289960933-5172-1-git-send-email-shan.hai@windriver.com>
	<1289960933-5172-2-git-send-email-shan.hai@windriver.com>
To: Shan Hai <shan.hai@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2010, at 8:28 PM, Shan Hai wrote:

> Conversion from float to integer should based on both the instruction
> encoding and the sign of the operand.
> 
> Signed-off-by: Shan Hai <shan.hai@windriver.com>
> ---
> arch/powerpc/math-emu/math_efp.c |   12 ++++++++----
> 1 files changed, 8 insertions(+), 4 deletions(-)

applied

- k
