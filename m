Date: Wed, 30 Oct 2002 14:15:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Ralph Blach <rblach@intrex.net>
Cc: Hollis Blanchard <hollis@austin.ibm.com>,
	embedded list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DBCR0 reset?
Message-ID: <20021030031555.GM15643@zax>
References: <1035919100.1013.1226.camel@granite.austin.ibm.com> <3DBF0764.10808@intrex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DBF0764.10808@intrex.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Oct 29, 2002 at 05:10:44PM -0500, Ralph Blach wrote:
> Hollis,
>
> The OS does this.  I send you the info on how to disable it tommorrow.

Please send it to the list as well - I've encountered this problem as
well.  Although it usually doesn't happen quite this quickly.

> Hollis Blanchard wrote:
> >Has anyone had problems with hardware breakpoints from external
> >debuggers? I'm using RISCWatch, which sets DBCR0 and IAC1 for me (yes
> >I've verified that). I'm then using 'echo > /proc/sys' to invoke my
> >code. However by the time I get to my sysctl proc handler, DBCR0 has
> >been reset from 0x80810000 to 0x00010000, hence IAC1 is ignored.
> >
> >I don't see much use of DBCR0, other than initialization and then save
> >during exception prologs and then restore during task restore. Can
> >anyone point me to where it might be reset?
> >
> >-Hollis

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
