Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B1242BDB0
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Oct 2004 23:44:34 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guido Guenther <agx@sigxcpu.org>
In-Reply-To: <20041004112105.GA5637@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
Content-Type: text/plain
Message-Id: <1096897172.23141.87.camel@gaston>
Mime-Version: 1.0
Date: Mon, 04 Oct 2004 23:39:32 +1000
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [agx@sigxcpu.org: [PATCH]: swsusp on linux-2.6.9-rc3]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2004-10-04 at 21:21, Guido Guenther wrote:
> Hi,
> attached is a forward port of Benjamin's pmdisk code to swsusp which got
> finally merged with pmdisk in 2.6.9-rc3. This has only been very lightly
> tested but survived a couple of suspend/resumes so far.
> Have fun,

I have more of that in a tree here that I need to rediff... paulus also
got real sleep working on his M10 based 15" albook by spying the MacOS
driver using that ndrver hack I wrote a while ago, hopefully, we'll get
that in shape & merged soon.

Ben.
