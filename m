Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 67373B7B83
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 20:02:44 +1000 (EST)
Subject: Re: [RFC] powerpc/irq: Add generic API for setting up cascaded IRQs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40909120705wdc8928ei75e9b8c952d1e45@mail.gmail.com>
References: <20090912054410.21847.63718.stgit@localhost.localdomain>
	<1252736925.8375.65.camel@pasglop>
	<fa686aa40909120705wdc8928ei75e9b8c952d1e45@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 20:02:38 +1000
Message-Id: <1253008958.8375.213.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> I'm a reverse polish kind of guy.  I preferring 'subject'_'action'
> over 'action'_'subject' just because it groups like subjects together.
>  But it doesn't matter much, especially in this case where 'subject'
> is in a group of exactly 1.  :-)
> 
> I'll do whichever you prefer.

I just caught myself calling something relocs_check instead of
check_relocs so I suppose it's fair game :-)

Whatever you want.

Cheers,
Ben. 
