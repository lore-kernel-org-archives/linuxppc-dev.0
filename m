Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp4.wanadoo.fr (smtp4.wanadoo.fr [193.252.22.27])
	by ozlabs.org (Postfix) with ESMTP id 6068D67A6C
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2005 04:11:39 +1100 (EST)
Date: Fri, 4 Mar 2005 18:00:26 +0100
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Message-ID: <20050304170026.GA4688@pegasos>
References: <Pine.LNX.4.58.0503040042380.20574@ppg_penguin.kenmoffat.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.LNX.4.58.0503040042380.20574@ppg_penguin.kenmoffat.uklinux.net>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Is emu10k1 broken in ppc ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 04, 2005 at 01:01:40AM +0000, Ken Moffat wrote:
>  First noticed this earlier this week, trying to upgrade my iBook from
> 2.6.8 to 2.6.11-rc5, using a debian config.  At that point, it didn't
> seem important to me.  Bit me again tonight when I tried to get my
> AmigaOne up to 2.6.10 from 2.6.9 using my existing config.  The case
> labels are SNDRV_EMU10K1_CODE_POKE and SNDRV_EMU10K1_CODE_PEEK, neither
> the header nor the code changed between 2.6.9 and 2.6.10.

This was fixed in the debian kernel. Try ou debian's kernel-source-2.6.10, or
get the patch from debian's svn.debian.org kernel repo archive.

Friendly,

Sven Luther
