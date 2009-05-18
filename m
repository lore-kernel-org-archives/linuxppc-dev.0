Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 50233DE0B2
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 23:23:22 +1000 (EST)
Message-Id: <9732983B-B67C-4831-BBAB-65472BE0F279@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1242630064.18075.48.camel@pasglop>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: fs_enet build breakage
Date: Mon, 18 May 2009 08:23:17 -0500
References: <1242630064.18075.48.camel@pasglop>
Cc: Kumar Gala <galak@gate.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2009, at 2:01 AM, Benjamin Herrenschmidt wrote:

> Hi Kumar
>
> Commit 4484079d517c2b6521621be0b1ea246ccc55c7d7 from your next branch
> breaks my 8xx test config with the following error:
>
> /home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c: In =20=

> function =91setup_immap=92:
> /home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c:=20
> 947: error: =91IMAP_ADDR=92 undeclared (first use in this function)
> /home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c:=20
> 947: error: (Each undeclared identifier is reported only once
> /home/benh/linux-powerpc-test/drivers/net/fs_enet/fs_enet-main.c:=20
> 947: error: for each function it appears in.)
>
> I'm still pushing it with a bunch of other stuff to "test" so people =20=

> get
> to find more breakage but it will need to be fixed for the actual =20
> "next"
> branch.
>
> Cheers,
> Ben.
>

I'm pretty sure the driver changes to address this are in dave's net-=20
next tree.

- k=
