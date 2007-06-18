Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id A308EDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 09:53:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: CONFIG_PS3_USE_LPAR_ADDR dramically increases boot time
Date: Tue, 19 Jun 2007 01:53:36 +0200
References: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>
	<F8264F80-17F0-47C6-AF58-9EBBF42DC24C@pobox.com>
	<46771140.5000205@am.sony.com>
In-Reply-To: <46771140.5000205@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706190153.36496.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 19 June 2007, Geoff Levand wrote:
> Arnd mention that he planed to re-do the spu region management, and
> I think with that we can use CONFIG_PS3_USE_LPAR_ADDR=3Dn and the spufs
> at the same time. =C2=A0Arnd, what is the status?

BenH already changed the spufs code to use the nopfn method instead of
nopage, so we no longer depend on sparsemem. Does that take care
of the problem?

	Arnd <><
