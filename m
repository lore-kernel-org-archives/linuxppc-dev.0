Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7FEEB7C06
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Sep 2009 17:41:30 +1000 (EST)
In-Reply-To: <1254123286.8421.14.camel@pasglop>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>	
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>	
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>	
	<1253843480.7103.492.camel@pasglop>
	<1253847827.7103.504.camel@pasglop>
	<20090925211848.GA3371@compile2.chatsunix.int.mrv.com>	
	<OFEC38184A.A376E71D-ONC125763E.0048F581-C125763E.00497FD3@transmode.se>
	<1254108060.8421.1.camel@pasglop>	
	<OF0EEAC985.DECE2C31-ONC125763F.002527BE-C125763F.002882FD@transmode.se>
	<1254123286.8421.14.camel@pasglop>
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache coherency
	rewrite
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFDC6987A3.07912749-ONC125763F.0029DCD1-C125763F.002A13D9@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 28 Sep 2009 09:39:35 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 28/09/2009 09:34:46:
>
> On Mon, 2009-09-28 at 09:22 +0200, Joakim Tjernlund wrote:
> >
> > > happy to stick with it until somebody comes up with a real good
> > reason
> > > to do more :-) 8xx is on life support and has been around for long
> >
> > yeah, I figured that too but Freescale seems to be cranking out new
> > variants still.
>
> Ugh ? And still not fixing the major core bugs ? Grmbl...

yes, I even had them chase down the problem so they know exactly where
it is :( I don't think it is in any errata though, but I haven't looked
for a few years.
