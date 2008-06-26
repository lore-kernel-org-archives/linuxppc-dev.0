Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AA79DE306
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:00:54 +1000 (EST)
Date: Thu, 26 Jun 2008 17:56:14 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2] fs_enet: restore promiscuous and multicast settings
	in restart()
Message-ID: <20080626175614.57ea5bbe@vitb.ru.mvista.com>
In-Reply-To: <200806261148.26569.laurentp@cse-semaphore.com>
References: <200806261148.26569.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Matvejchikov Ilya <matvejchikov@gmail.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 26 Jun 2008 11:48:22 +0200
Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

> The restart() function is called when the link state changes and resets
> multicast and promiscuous settings. This patch restores those settings at the
> end of restart().
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
Acked-by: Vitaly Bordug <vitb@kernel.crashing.org>



-- 
Sincerely, 
Vitaly
