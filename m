Return-Path: <Bernhard.Weirich@riedel.net>
Received: from mail.riedel.net (mail.riedel.net [213.70.193.150])
	by ozlabs.org (Postfix) with ESMTP id 993E4B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Dec 2009 02:13:41 +1100 (EST)
From: "Weirich, Bernhard" <Bernhard.Weirich@riedel.net>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: enabling USB Host controller on ppc405ex based board
Message-ID: <CE92B8B581B4584FB8CA86B51EDE8AC52441088CFD@wupexchange.riedel.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Date: Sun, 20 Dec 2009 15:13:42 -0000

If you enable PCI on 405EX you MUST have valid clock signals on the PCIE po=
rts. If you do not have these on your board your kernel will hang just as y=
ou said.

I do not know why PCI is required for the USB controller, if it is just for=
 some software interfaces to be present then you can try to remove the PCIE=
 entries from the kilauea.dts device tree.
Then you will be able to boot even without proper clock signals, yet I do n=
ot know whether the USB controller will work.

Best regards,
Bernhard
