Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5013DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 14:19:35 +1000 (EST)
Message-ID: <48E05742.1030609@pobox.com>
Date: Mon, 29 Sep 2008 00:19:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] pata_platform struct resource signness fix
References: <20080925083622.GA2701@debian> <48DB51C3.6040504@linux.net.cn>
	<2a27d3730809250340p5cbd307crb1f70e5fb1a2fc1f@mail.gmail.com>
	<20080925104847.GA311@oksana.dev.rtsoft.ru>
In-Reply-To: <20080925104847.GA311@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>, Wang Jian <lark@linux.net.cn>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Thu, Sep 25, 2008 at 06:40:59PM +0800, Li Yang wrote:
>> On Thu, Sep 25, 2008 at 4:54 PM, Wang Jian <lark@linux.net.cn> wrote:
>>> The alternative fix can be.
>> This one is better as 0 is defined as 'invalid irq' for all
>> architectures.  Added linux-ide and Anton to cc.
> 
> Thanks for the correct Cc.
> 
> I've sent a patch to fix the issue more than a month ago.
> 
> http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg22851.html
> 
> Jeff, could you apply the patch?

Can you resend, I don't seem to have it...
