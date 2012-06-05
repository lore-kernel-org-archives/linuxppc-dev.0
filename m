Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 19234B6F86
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 08:15:24 +1000 (EST)
Message-ID: <1338934495.7150.112.camel@pasglop>
Subject: Re: kernel panic during kernel module load (powerpc specific part)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Date: Wed, 06 Jun 2012 08:14:55 +1000
In-Reply-To: <20120605113225.GA11215@visitor2.iram.es>
References: <4FC62FB9.8010701@nsn.com> <1338420242.27402.2.camel@concordia>
 <192298D25D96A042975E372855100DB70FEA87@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120531110439.GA17373@visitor2.iram.es>
 <1338542315.16119.50.camel@pasglop>
 <192298D25D96A042975E372855100DB70FF0E2@039-SN2MPN1-011.039d.mgd.msft.net>
 <20120604110305.GA16707@visitor2.iram.es>
 <1338847242.7150.83.camel@pasglop>
 <20120605113225.GA11215@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wrobel Heinz-R39252 <r39252@freescale.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Steffen Rumler <steffen.rumler.ext@nsn.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-06-05 at 13:32 +0200, Gabriel Paubert wrote:
> - gcc-4.6 and gcc-4.7 behave identically, if -Os is set, they
>   generate by default lmw/stmw. But if I combine -Os with 
>   -mno-multiple, they call the helper functions.
> 
> In other words, on this system, gcc-4.4 is broken but should not
> cause any harm. gcc-4.6 and gcc-4.7 look correct, but are there
> any processors on which -mno-multiple is worth setting?

It could be an artifact of the -mtune we use, dunno. And yes, I'm pretty
sure some embedded processors don't like multiple load/store.

Cheers,
Ben.
