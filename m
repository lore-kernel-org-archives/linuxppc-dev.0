Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C9D1B70DA
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Dec 2010 07:54:21 +1100 (EST)
Subject: Re: PMU_IOC_SLEEP failed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jjDaNiMoTh <jjdanimoth@gmail.com>
In-Reply-To: <AANLkTinBQAMvmmNP5S_=++UOQDoTe-1efD39VF0PO5kB@mail.gmail.com>
References: <AANLkTiksBGDR=vJLArgShP8U_NWZ2OWXc65wiXRLv4kr@mail.gmail.com>
	<1293550353.19556.224.camel@thor.local>
	<AANLkTinBQAMvmmNP5S_=++UOQDoTe-1efD39VF0PO5kB@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Dec 2010 07:54:08 +1100
Message-ID: <1293569648.17779.20.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-12-28 at 17:39 +0100, jjDaNiMoTh wrote:
> 2010/12/28 Michel Dänzer <michel@daenzer.net>:
> [cut]
> > What exactly does "can't switch over VT" mean?
> After X is running, I can't switch over ctrl + alt + f{1,2,3,4,5,6}
> consoles ( the screen flicker, then blank ). If I switch to f7, where
> X live, all return to normal and I can see normal X window.
> This doesn't happend with X active.
> 
> > Sleep requires radeonfb, is that enabled?
> 
> Of course, but I think there is something wrong:
> 
> (dmesg..)
> [...]
> radeonfb_pci_register BEGIN
> radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0xb8000000-0xbfffffff pref]
> radeonfb (0000:00:10.0): cannot request region 0.
> radeonfb: probe of 0000:00:10.0 failed with error -16

That looks bad indeed. Send me the complete dmesg, a snapshot of the
device-tree (tar -c /proc/device-tree >foo.tar) and the output
of /proc/iomem please.

Cheers,
Ben.
