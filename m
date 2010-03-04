Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2AB96B7D55
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Mar 2010 03:46:00 +1100 (EST)
Subject: Re: [PATCH 44/66] arch/powerpc/sysdev/cpm2_pic.h: Checkpatch cleanup
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1267289508-31031-45-git-send-email-andrea.gelmini@gelma.net>
Date: Thu, 4 Mar 2010 10:45:13 -0600
Message-Id: <05F3112F-EE86-4682-B89D-E6E6C5EB8FC8@kernel.crashing.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
	<1267289508-31031-45-git-send-email-andrea.gelmini@gelma.net>
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 27, 2010, at 10:51 AM, Andrea Gelmini wrote:

> arch/powerpc/sysdev/cpm2_pic.h:6: ERROR: "(foo*)" should be "(foo *)"
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
> arch/powerpc/sysdev/cpm2_pic.h |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
