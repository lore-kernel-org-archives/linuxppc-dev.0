Return-Path: <adrian.craine@nec.com.au>
Received: from ns2.nec.com.au (ns2.nec.com.au [147.76.180.2])
	by ozlabs.org (Postfix) with ESMTP id D0719DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 May 2007 08:12:04 +1000 (EST)
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 May 2007 07:54:53 +1000 (EST)
Message-ID: <4640F08E.5040608@nec.com.au>
Date: Wed, 09 May 2007 07:50:06 +1000
From: Adrian Craine <adrian.craine@nec.com.au>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: zImage.elf loads but does not start
References: <10079346.post@talk.nabble.com>	<10142161.post@talk.nabble.com><406A31B117F2734987636D6CCC93EE3C0159BAAE@ehost011-3.exch011.intermedia.net><10165159.post@talk.nabble.com>	<10323147.post@talk.nabble.com><463B5422.6030105@ru.mvista.com>	<10372619.post@talk.nabble.com>
	<406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C017019FD@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org, Mirek23 <miroslaw.dach@psi.ch>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Leonid wrote:
> rootpath=
> [    9.130834] Looking up port of RPC 100003/2 on 129.129.130.106
> [    9.207363] Looking up port of RPC 100005/1 on 129.129.130.106
> [    9.303794] VFS: Mounted root (nfs filesystem).
> [    9.359316] Freeing unused kernel memory: 96k init
> [    9.422162] Warning: unable to open an initial console.
>
>   
The exact device node this requires is /dev/console c 5 1
That should solve your issue.

Cheers,
             Adrian.
