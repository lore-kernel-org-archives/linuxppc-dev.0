Date: Tue, 24 Jul 2001 21:13:45 +0200
From: Olaf Hering <olh@suse.de>
To: Matt Porter <mmporter@home.com>
Cc: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>,
	"PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4.6 kernel on MCP750 board
Message-ID: <20010724211345.B20688@suse.de>
References: <619D608DD3F0D311882C009027732E1A35320B@ntserver.act.domain> <20010719113849.A30665@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010719113849.A30665@cx258813-a.chnd1.az.home.com>; from mmporter@home.com on Thu, Jul 19, 2001 at 11:38:49AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 19, Matt Porter wrote:

>
> On Wed, Jul 18, 2001 at 09:54:41AM +1000, Rudolf Ladyzhenskii wrote:
> >
> > Hi, all
> >
> > I am trying to put the latest kernel on Motorola MCP750 card. 2.2 kernel
> > used to work fine, but 2.4.6 have some PCI problems.
> > It can not allocate resources to network interface and, as a result, I can
> > not boot.
> > Startup dump attached.
>
> The PCI subsystem is shooting itself in the foot when it sees a P2P
> bridge with I/O and Mem windows disabled.  That's the case when you
> plug in a system master (that uses a transparent bridge to cPCI) in
> by itself.  A peripheral card in any slot will avoid the issue.
>
> Apply the following patch (current linuxppc_2_4_devel / 2.4.7pre8) to
> cure the problem:

That fixed my mtx+, thanks :)
Changeset 1.152 in _2_4 broke it.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
