Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 7F1762BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 07:53:33 +1000 (EST)
Date: Mon, 4 Oct 2004 14:53:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041004215331.GC32692@smtp.west.cox.net>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
	<20041001220648.GJ21896@smtp.west.cox.net>
	<4160E898.9080905@intracom.gr>
	<35fb2e5904100405451423c391@mail.gmail.com>
	<80A86B0F-1624-11D9-A7BA-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80A86B0F-1624-11D9-A7BA-003065F9B7DC@embeddededge.com>
Cc: jonathan@jonmasters.org, linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 04, 2004 at 12:43:21PM -0400, Dan Malek wrote:
> 
> On Oct 4, 2004, at 8:45 AM, Jon Masters wrote:
> 
> >I think that's an approach which works up to a point. It's nice to
> >have a hierachy of devices like with OF because then we can infer
> >things like order of devices on a bus that need to be shutdown for a
> >suspend.
> 
> The problem with a hierarchy of devices is that isn't the kind of
> information we need in an embedded system.  With the embedded
> system, you have a pretty good idea what you have.  We need
> _environment_ information, such as MAC addresses, memory sizes
> and other information tidbits are are likely to vary within an embedded
> system.  This is something an OF tree doesn't give us.

There's nothing saying that what we know to Always Be True must be Put
Into The Tree.  We can just have say, /ethN/mac for the mac address we
yank out of firmware somehow, but leave the addresses we know as part of
the OCP table, or whatever.

No one is saying we have to have a tree that fully describes every bit
of the system.  Just a tree that describes what we don't know at compile
time.  The tree for what we know is in OCP already. :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
