Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id B996EDE4CE
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 06:51:37 +1000 (EST)
Message-Id: <D57C4E4C-55C3-4886-8128-14CAC80EE475@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: jschopp@austin.ibm.com
In-Reply-To: <20080618201821.GA23865@gamma>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/2] Power7 architected entry
Date: Wed, 18 Jun 2008 15:51:35 -0500
References: <20080618201124.GA23828@gamma> <20080618201821.GA23865@gamma>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 3:18 PM, jschopp@austin.ibm.com wrote:

> Add an entry for Power7 architected mode and add "(raw)" to Power7  
> raw mode to
> distinguish it more clearly.
>
> Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
> ---
> arch/powerpc/kernel/cputable.c             |   48 +++++++++++++++++++ 
> ++++++++++
> arch/powerpc/platforms/pseries/cpu_setup.S |    6 +++
> include/asm-powerpc/cputable.h             |    9 +++++
> 3 files changed, 63 insertions(+)

Huh? This patch only changes one file.


-Olof
