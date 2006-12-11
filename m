Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B9B2967DC8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 05:36:18 +1100 (EST)
Date: Mon, 11 Dec 2006 21:36:28 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: Re: [PATCH] [FS_ENET] OF-related update for FEC and SCC MAC's
Message-ID: <20061211213628.23dcc319@vitb.ru.mvista.com>
In-Reply-To: <20061211180048.17991.59030.stgit@localhost.localdomain>
References: <20061211180048.17991.59030.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Garzik <jeff@garzik.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 11 Dec 2006 21:00:49 +0300
Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> 
> Updated direct resource pass with ioremap call, make it grant proper IRQ
> mapping, stuff incompatible with the new approach were respectively put  under 
> #ifndef CONFIG_PPC_MERGE.

Hrm, Signed-off-by: missed, I'll resend, sorry about that.
-- 
Sincerely, 
Vitaly
