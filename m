Return-Path: <prvs=11509943cb=mhench@elutions.com>
Received: from mail.elutions.com (mail.elutions.com [64.31.159.3])
	by ozlabs.org (Postfix) with ESMTP id 2A85BB7008
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Jun 2011 04:10:07 +1000 (EST)
Received: from mail.elutions.com (127.0.0.1) by mail.elutions.com (MlfMTA
	v3.2r9) id hvjcdc0171sb for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 12:41:49 -0400 (envelope-from
	<prvs=11509943cb=mhench@elutions.com>)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: NAND BBT corruption on MPC83xx
Date: Sat, 18 Jun 2011 13:55:01 -0400
Message-ID: <F87D23B7E1F84E4AB52E4FA4A55F85DC0259E343@tpamail.elutions.com>
In-Reply-To: <20110617163442.204348a0@schlenkerla.am.freescale.net>
From: "Mike Hench" <mhench@elutions.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Matthew L. Creech" <mlcreech@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> As for the corruption, could it be degradation from repeated reads of
that
> one page?

Read Disturb. I Did not know SLC did that.
It just takes 10x as long as MLC, on the order of a million reads.
Supposedly erasing the block fixes it.
It is not a permanent damage thing.
I was seeing ~9 hours before failure with heavy writes.
~4GByte/hour =3D 2M pages, total ~18 million reads before errors in that
last block showed up.

Cool. Now we know.
Thanks.

Mike Hench
