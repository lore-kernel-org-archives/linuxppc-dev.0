Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound7-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 36310DDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 09:56:02 +1000 (EST)
Message-ID: <46771B8C.7000202@am.sony.com>
Date: Mon, 18 Jun 2007 16:55:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: CONFIG_PS3_USE_LPAR_ADDR dramically increases boot time
References: <F4482BED-242B-42AD-96FF-3CB14B6BC5BE@watson.ibm.com>
	<F8264F80-17F0-47C6-AF58-9EBBF42DC24C@pobox.com>
	<46771140.5000205@am.sony.com> <200706190153.36496.arnd@arndb.de>
In-Reply-To: <200706190153.36496.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Jimi Xenidis <jimix@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 19 June 2007, Geoff Levand wrote:
>> Arnd mention that he planed to re-do the spu region management, and
>> I think with that we can use CONFIG_PS3_USE_LPAR_ADDR=n and the spufs
>> at the same time.  Arnd, what is the status?
> 
> BenH already changed the spufs code to use the nopfn method instead of
> nopage, so we no longer depend on sparsemem. Does that take care
> of the problem?

I think that there is a good chance it will, but I'll need to look at
it, as it was some time ago I did that work.

-Geoff
