Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 21050DDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 20:48:50 +1000 (EST)
Date: Thu, 25 Sep 2008 14:48:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_platform struct resource signness fix
Message-ID: <20080925104847.GA311@oksana.dev.rtsoft.ru>
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn>
	<2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Wang Jian <lark@linux.net.cn>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 06:40:59PM +0800, Li Yang wrote:
> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
> > The alternative fix can be.
> 
> This one is better as 0 is defined as 'invalid irq' for all
> architectures.  Added linux-ide and Anton to cc.

Thanks for the correct Cc.

I've sent a patch to fix the issue more than a month ago.

http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg22851.html

Jeff, could you apply the patch?

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
