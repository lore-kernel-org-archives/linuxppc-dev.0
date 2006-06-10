Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id EDDDA67C33
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 10:56:52 +1000 (EST)
Subject: Re: RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149899665.12687.95.camel@localhost.localdomain>
References: <20060608205048.113800@gmx.net>
	<1149899665.12687.95.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 20:46:32 -0400
Message-Id: <1149900393.4686.4.camel@mindpipe>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-06-10 at 10:34 +1000, Benjamin Herrenschmidt wrote:
> > This leads me to the question, if there are any plans to include the dma_mmap_coherent() function (for powerpc/ppc and/or any other platform) in one of the next kernel versions and if an adapation of the ALSA drivers is planned. Or is there a simple way (hack) to fix this problem?
> 
> You are welcome to do a patch implementing this :)

Please cc: alsa-devel when you do so.

Lee
