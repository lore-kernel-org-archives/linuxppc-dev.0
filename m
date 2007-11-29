Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 7D50FDDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 11:14:13 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Thu, 29 Nov 2007 01:13:28 +0100
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711272335.36981.arnd@arndb.de> <474DF2D8.9010407@am.sony.com>
In-Reply-To: <474DF2D8.9010407@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711290113.29024.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>,
	Jan Kratochvil <jan.kratochvil@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 28 November 2007 23:59:36 Geoff Levand wrote:
> > This sounds like a bug recently reported by Uli Weigand. BenH
> > said he'd take a look, but it probably fell under the table.
> > The problem found by Uli is that on certain processors (Cell/B.E.
> > in his case), the DABRX register needs to be set in order for
> > the DABR to take effect.
>
> Just as a note, the PS3's lv1_set_dabr(), which we used for
> ppc_md.set_dabr sets up both the DABRX and DABR registers.

Yes, I know. I tried it on the PS3 first and couldn't reproduce
the bug he saw on the blade.

	Arnd <><
