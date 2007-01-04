Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0785ADDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 21:43:20 +1100 (EST)
Date: Thu, 4 Jan 2007 10:53:45 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] add delay around sl82c105_reset_engine calls
Message-ID: <20070104105345.046e7aec@localhost.localdomain>
In-Reply-To: <20070104064254.GA31986@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
	<20061204124026.GB28159@aepfle.de>
	<20061204130254.424c7979@localhost.localdomain>
	<20070104064254.GA31986@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 4 Jan 2007 07:42:54 +0100
Olaf Hering <olaf@aepfle.de> wrote:

> On Mon, Dec 04, Alan wrote:
> 
> > On Mon, 4 Dec 2006 13:40:26 +0100 (MET)
> > Olaf Hering <olaf@aepfle.de> wrote:
> > 
> > > 
> > > 
> > > the hald media changed polling does really confuse things.
> > > noone knows why the delays are needed, but they give us access to
> > > the CD.
> > 
> > Can you tell me what happens if you completely pull the reset out of the
> > dma_end function. Do you still need delays then.
> 
> An udelay(50) will give reliable access to the drive, but there is still
> one (or more) EH reset. The drive works without EH resets with udelay(100).
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Acked-by: Alan Cox <alan@redhat.com>

This wants revisiting some day to understand the interaction better but
for now it gets us up and running properly.
