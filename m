From: jcarr@mail.linuxppc.org
Date: Mon, 9 Oct 2000 23:17:10 -0400 (EDT)
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: call_prom & call_method_1
In-Reply-To: <Pine.HPX.4.10.10010100221110.16113-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.4.21.0010092310290.1339-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks. that's quite a doc. It'll take a while to grok.
Jeff
jcarr@linuxppc.org

On Tue, 10 Oct 2000, Gabriel Paubert wrote:

>
> On Mon, 9 Oct 2000 jcarr@mail.linuxppc.org wrote:
>
> >
> > > >1) Does anyone know what other strings can be sent to call_prom besides
> > > >"getprop", "findpackage", "interpret"?
> > >
> > > claim, release, ... well, those are defined in the OF client interface
> > > spec of the OF standard. Firmorks has, I think, a separate book for them
> >
> > Ah ha! That explains it - that's the one firmworks manual I don't have.
>
> Hmm, I found a description in a ps file I downloaded a few days ago when
> surfing somewhere between Apple, Firmworks and Sun. Look for 1275.ps or
> 12750d12.ps in an FTP directory, quite a lot of functons of the client
> interface are defined.
>
> BTW: the name of the package is /openprom/client-services.
>
> 	Gabriel
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
