Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2609BB6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Jun 2011 09:33:39 +1000 (EST)
Subject: Re: [RFC PATCH 0/1] BPF JIT for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <750BF3E9-A788-4302-8AA1-4630614E20DC@kernel.crashing.org>
References: <4E042867.5020902@ozlabs.org>
	<750BF3E9-A788-4302-8AA1-4630614E20DC@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 25 Jun 2011 09:33:31 +1000
Message-ID: <1308958411.32158.335.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-06-24 at 04:16 -0500, Kumar Gala wrote:
> > Tested in-situ (tcpdump with varying complexity filters) and with a random BPF
> > generator; I haven't verified loads from the fall back skb_copy_bits path.  Bug
> > reports/testing would be very welcome.
> 
> Would be nice to get PPC32 support as well. 

Patches welcome :-)

Cheers,
Ben.
