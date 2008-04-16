Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 80C19DDFC6
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 02:05:41 +1000 (EST)
Date: Wed, 16 Apr 2008 20:05:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [RFC fs_enet: Convert MII bitbang driver to use GPIO lib
Message-ID: <20080416160540.GB442@polina.dev.rtsoft.ru>
References: <200804161640.42693.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200804161640.42693.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 04:40:42PM +0200, Laurent Pinchart wrote:
> This patch converts the MII bitband driver to use GPIO lib for GPIO access.
> The driver can now handle MDC and MDIO on different GPIO banks.
> 
> The patch depends on Anton Vorontsov GPIO lib support scheduled for 2.6.26.
> It is by no means complete, I just would like to get some feedback on the
> approach. I'll resubmit it when the CPM2 GPIO support patches will be
> available in the powerpc git tree.

Cool! By the way, maybe it is worth splitting it into completely separate
driver, e.g. net/mdio_gpio.c? Plus, keep in mind that somebody will
eventually want this cool stuff with platform_device bindings in addition. :-)

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
