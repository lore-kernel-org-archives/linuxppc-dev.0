Return-Path: <agx@sigxcpu.org>
Received: from honk1.physik.uni-konstanz.de (honk1.physik.uni-konstanz.de
	[134.34.140.224])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F80E2BDB0
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 00:01:11 +1000 (EST)
Date: Mon, 4 Oct 2004 15:51:09 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041004135108.GB5637@bogon.ms20.nix>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096897172.23141.87.camel@gaston>
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

On Mon, Oct 04, 2004 at 11:39:32PM +1000, Benjamin Herrenschmidt wrote:
> I have more of that in a tree here that I need to rediff... paulus also
> got real sleep working on his M10 based 15" albook by spying the MacOS
> driver using that ndrver hack I wrote a while ago, hopefully, we'll get
> that in shape & merged soon.
Great! Let me know if I can help to get this merged. What exactly is the
ndrver hack? Google didn't show up anything.
 -- Guido
