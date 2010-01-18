Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 8F52AB7CFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 19:26:28 +1100 (EST)
Received: by pzk29 with SMTP id 29so2667175pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jan 2010 00:26:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF593A1F75.3C3C7D18-ONC12576AF.002B1239-C12576AF.002BB30A@transmode.se>
References: <cb9ecdfa1001172304q132d5324qa963d0d5cdfb7806@mail.gmail.com>
	<OF593A1F75.3C3C7D18-ONC12576AF.002B1239-C12576AF.002BB30A@transmode.se>
Date: Mon, 18 Jan 2010 16:26:26 +0800
Message-ID: <cb9ecdfa1001180026q5856b170t3f4c71191a7b99d8@mail.gmail.com>
Subject: Re: jffs2_gcd_mtdx thread and umount problem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
	linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, umount / reboot command doesn't hang after first boot + wait for
20 minutes. The jffs2_gcd_mtdx will re-erase empty blocks but how do I
know it is finished?

BTW, why jffs2_gcd_mtd need to re-erase empty blocks and it will cause
some command cannot work if erase block is necessary. I mean many
pepple could meet this problem if it is need to erase empty block and
how do they overcome or workaround it.

Thank you so much, Jocke
BRs, H. Johnny

> I guess this is the first reboot after mounting a new JFFS2 FS?
> Then JFFS2 is reerasing empty blocks and you will have to wait
> until it is done.
>
> I posted a patch long ago for this, but it was racy w.r.t JFSS2 module un=
load so
> it didn't make it into the repo. Search the list for
> "[JFFS2] Stop erasing blocks when rebooting." to find my old patch
>
> =A0Jocke
>
>
