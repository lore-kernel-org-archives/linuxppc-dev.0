Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EEF52BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Oct 2004 09:33:05 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
In-Reply-To: <200410050737.59754.toojays@toojays.net>
References: <20041004112105.GA5637@bogon.ms20.nix>
	<1096897172.23141.87.camel@gaston>
	<200410050737.59754.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1096932475.9516.119.camel@gaston>
Mime-Version: 1.0
Date: Tue, 05 Oct 2004 09:27:56 +1000
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

On Tue, 2004-10-05 at 08:07, John Steele Scott wrote:
> On Mon, 4 Oct 2004 11:09 pm, Benjamin Herrenschmidt wrote:
> > I have more of that in a tree here that I need to rediff... paulus also
> > got real sleep working on his M10 based 15" albook by spying the MacOS
> > driver using that ndrver hack I wrote a while ago, hopefully, we'll get
> > that in shape & merged soon.
> 
> Presumably this same technique could be used to figure out sleep for the M9 in 
> the iBook G4s? I've been hanging out for that feature for some time.

Yes, I have some traces from the driver on this one already. I'll compare
them to what we got on the M10 and see if I can produce something useful,
but I'll need volunteers to test :)

Ben.
