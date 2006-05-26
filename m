Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (rtr.ca [64.26.128.89])
	by ozlabs.org (Postfix) with ESMTP id 0F68967B17
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 02:21:38 +1000 (EST)
Message-ID: <44772B10.7040300@rtr.ca>
Date: Fri, 26 May 2006 12:21:36 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH/2.6.17-rc4 10/10]  bugs fix for marvell SATA on powerp
	c pl atform
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
	<1147935734.17679.93.camel@localhost.localdomain>
	<446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
	<20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca>
	<20060526114245.GA32330@powerlinux.fr>
	<44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr>
	<447722FF.9020202@rtr.ca> <20060526160156.GA11778@powerlinux.fr>
In-Reply-To: <20060526160156.GA11778@powerlinux.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven Luther wrote:
> On Fri, May 26, 2006 at 11:47:11AM -0400, Mark Lord wrote:
>
>> Meanwhile, I just booted 2.6.17-rc5-git1 (latest kernel.org) on my Mac G3
>> box here, and sata_mv seems to be behaving for me (thus far).
> 
> Mmm, this is a G3, while i have a G4. The G4 does some I/O reordering, which
> we don't have with a G3, so this may be the cause. 

MMmm.. is your G4 using a 64-bit kernel, or a 32-bit kernel?
The driver is a complete unknown (for me, at least) on 64-bit systems,
as I don't have one (of any processor type) here yet.

> Do you have a mac version of the board, with a forth/OF bios in it ? Or a
> normal PC card, which is thus uninitialized ? 

The board claims to be "mac" compatible, so it probably has an OF bios on it,
but I have not verified this yet.

Cheers
