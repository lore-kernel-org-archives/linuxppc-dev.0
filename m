Date: Mon, 11 Jan 1999 08:11:01 -0800 (PST)
From: Matt McLean <keys@yikes.com>
To: Tom Rini <trini@globe.linuxppc.org>
cc: Olaph Swensen <olaph@takilma.nurk.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: compiling ssh / R5 install
In-Reply-To: <Pine.LNX.3.96.990110161916.15302A-100000@globe>
Message-ID: <Pine.BSF.4.01.9901110809020.8099-100000@brio.yikes.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 10 Jan 1999, Tom Rini wrote:

__USE_GNU is the internal macro... compile with -D_GNU_SOURCE. :-)

m.

> 
> On Tue, 5 Jan 1999, Olaph Swensen wrote:
> 
> > login.c:437: structure has no member named `ut_syslen'
> 
> #if out this line or remove
> 
> > login.c:441: structure has no member named `e_termination'
> > login.c:442: structure has no member named `e_exit'
> 
> __e_*
> 
> > login.c:454: `WTMPX_FILE' undeclared (first use in this function)
> > login.c:454: (Each undeclared identifier is reported only once
> > login.c:454: for each function it appears in.)
> 
> Needs a __USE_GNU or something along those lines, IIRC.  At least these
> are glibc 2.1 changes/probelsm for everybody. :)


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
