Subject: Re: random ramblings on 8xx patches (long and tedious :-)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Dan Malek <dan@embeddededge.com>
Cc: "Wells, Charles" <Charles.Wells@nielsenmedia.com>,
	"'Robert P. J. Day'" <rpjday@mindspring.com>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <75D875A6-DC05-11D8-9220-003065F9B7DC@embeddededge.com>
References: 
	 <762A181C0D966E459A2EB3B810142C7703861518@nmrusdunsx12.nmrlan.net>
	 <75D875A6-DC05-11D8-9220-003065F9B7DC@embeddededge.com>
Content-Type: text/plain
Message-Id: <1090572504.4399.86.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Fri, 23 Jul 2004 10:48:25 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-07-22 at 19:35, Dan Malek wrote:
> On Jul 22, 2004, at 1:10 PM, Wells, Charles wrote:
>
> > ....... The real problem is that the
> > MPC850 USB controller was designed for target-mode applications and not
> > host-mode applications.

And even in target mode I see unexpected underruns, handshake timeouts
and a stucking interrupt endpoint. The software can recover from these
errors though.

> There are Linux versions of software that work fine in many
> applications.
> USB in general doesn't rate high on my list of engineering successes.

very much right. It works, we don't know why :)

> I'm never surprised when I plug something in to any kind of system
> and it doesn't work.
>
>
> 	-- Dan

Jaap-Jan


--
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
