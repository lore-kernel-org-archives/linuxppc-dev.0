Return-Path: <shemminger@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 71F1467C6F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 08:09:58 +1000 (EST)
Date: Mon, 21 Aug 2006 15:09:35 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Miller <davem@davemloft.net>
Subject: Re: NAPI documentation
Message-ID: <20060821150935.0d59791b@localhost.localdomain>
In-Reply-To: <20060821.150509.111198790.davem@davemloft.net>
References: <200608191325.19557.arnd@arndb.de>
	<200608201948.20596.arnd@arndb.de>
	<20060821134053.7225987b@dxpl.pdx.osdl.net>
	<20060821.150509.111198790.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, arnd@arndb.de, netdev@vger.kernel.org, jklewis@us.ibm.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens.Osterkamp@de.ibm.com, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Aug 2006 15:05:09 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Stephen Hemminger <shemminger@osdl.org>
> Date: Mon, 21 Aug 2006 13:40:53 -0700
> 
> > Please edit and improve
> > 	http://linux-net.osdl.org/index.php/NAPI
> > 
> > When the page is in good shape, I will de-wiki it to place in kernel doc tree.
> 
> How do I edit the introduction paragraphs at the top? 

Click edit on wiki and it is the first sentence.


> I want to edit
> this sentence since it sounds awful:
> 
> 	NAPI ("New API") is a modification to the packet process, ...
> 
> I want to change "packet process" to something more descriptive
> and accurate.
>

Yes.

Also, does Jamal have a link to his UKUUG paper?

-- 
Stephen Hemminger <shemminger@osdl.org>

All non-trivial abstractions, to some degree, are leaky.
