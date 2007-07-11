Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id CEFB2DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 05:00:26 +1000 (EST)
Message-ID: <46952943.2080007@ru.mvista.com>
Date: Wed, 11 Jul 2007 23:02:27 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] mmio ide support for mpc8349-itx target
References: <20070707094852.9473.21013.stgit@localhost.localdomain>	<20070707094900.9473.48577.stgit@localhost.localdomain>	<468FC376.2040405@ru.mvista.com>
	<20070710145256.6ac64e11@localhost.localdomain>
In-Reply-To: <20070710145256.6ac64e11@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Vitaly Bordug wrote:

>>>+
>>>+#ifdef CONFIG_MPC834x_ITX  

>>    Erm, isn't this stuff misplaced? Is this really SoC device? I
>>remember seeng this in the arch/ppc/ platform code before (in the
>>internal tree)...

> The point is to declare methods bsp, as mmio access may effectively vary (having bugs or intentionally) from platform to platform. All-in-one driver approach is nice but might be an issue to handle/maintain.

    You misunderstood. Why this was placed in fsl_soc.c and not in the proper 
platform code (as it was in the internal tree even)?

MBR, Sergei
