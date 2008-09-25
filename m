Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 99298DE070
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 01:47:30 +1000 (EST)
Date: Thu, 25 Sep 2008 19:47:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Wang Jian <lark@linux.net.cn>
Subject: Re: [PATCH] pata_platform struct resource signness fix
Message-ID: <20080925154727.GA1620@oksana.dev.rtsoft.ru>
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn>
	<2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
	<48DBAF4F.3020003@linux.net.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48DBAF4F.3020003@linux.net.cn>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	linux-ide@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 11:33:35PM +0800, Wang Jian wrote:
> Li Yang wrote:
>> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
>>> The alternative fix can be.
>>
>> This one is better as 0 is defined as 'invalid irq' for all
>> architectures.  Added linux-ide and Anton to cc.
>
> However, this is not very true. Just git grep "#define NO_IRQ" and see. It
> seems that the NO_IRQ is in transition from (-1) to (0).

Yeah, there is a mess, but it gets better as time goes by.
The platforms/drivers should be fixed, since 0 is the only
invalid VIRQ.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
