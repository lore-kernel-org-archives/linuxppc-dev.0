Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1466ADDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 05:07:02 +1100 (EST)
Message-ID: <474C5CD2.7080208@ru.mvista.com>
Date: Tue, 27 Nov 2007 21:07:14 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 3/3] [POWERPC] MPC8349E-mITX: introduce localbus and pata
	nodes
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153940.GC14183@localhost.localdomain>
	<474C3C79.5060908@ru.mvista.com>
	<20071127164101.GA14790@localhost.localdomain>
	<474C49D5.2000206@ru.mvista.com>
	<20071127173456.GA15693@localhost.localdomain>
	<474C5513.6010801@ru.mvista.com>
	<20071127174826.GA15980@localhost.localdomain>
In-Reply-To: <20071127174826.GA15980@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

>>>>>2. "ioport" because shift^Wstride ;-) applies only to the io range
>>>>>(yes, it's obvious, but worth open-wording, no?).

>>>> Contrarywise, to memory range.

>>>By io range I meant "I/O base", in contrast to "CTL base".

>>>There is no need to apply shifting for CTL. That's why ioport-*
>>>appeared in the first place.

>>   So, a matter of wrong terminology then. The thing that you meant by 
>>   "I/O" is actually called "command block".

> Yes. And IO is the second name.

    I'd say the first place in drivers/ide belongs to the historic name 
"taskfile". The "command block" which is as ATA standard calls it, is hardly used.

> It's used widespread in the drivers/ide/.

    Don't remember seeing it.

> Now you understand why I'm so reluctant to hanging up different
> labels on the single thing? ;-)

    :-)

MBR, Sergei
