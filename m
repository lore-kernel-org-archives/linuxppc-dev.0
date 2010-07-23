Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C61DB70A6
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jul 2010 08:16:55 +1000 (EST)
Subject: Re: [PATCH] powerpc:  fix .data..init_task output section
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20100723135859.GA26879@merkur.ravnborg.org>
References: <20100628005900.28d4a8e0@lappy.seanm.ca>
	<20100712203435.08a3e90f@lappy.seanm.ca>
	<20100713095024.GA10494@merkur.ravnborg.org>
	<20100722195008.72fe2e71@lappy.seanm.ca>
	<20100723135859.GA26879@merkur.ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 24 Jul 2010 08:16:47 +1000
Message-ID: <1279923407.1970.88.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > > 
> > > On the assumption that Sean reports that it fixes
> > > the warnings/boot issue here is a real patch.
> > > 
> > > Ben - will you take it via the popwerpc tree
> > > or shall I ask Michal to take it via kbuild?
> > > 
> > > 	Sam
> 
> Sorry for the bad initial subject line!
> As Sean reported that the patch fixes his isuse it
> deserves a:
> 
> Tested-by: Sean MacLennan <smaclennan@pikatech.com>

Heh. Too late, I already sent it to Linus :-)

Ben.
