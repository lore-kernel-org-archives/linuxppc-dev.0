Date: Thu, 21 Jan 1999 14:07:15 -0600 (CST)
From: Kevin Puetz <kp11901@mail.cedarnet.org>
To: j k <j_kn@yahoo.com>
cc: Kevin Puetz <kp11901@cedarnet.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: ppp problem
In-Reply-To: <19990121195124.20532.rocketmail@send204.yahoomail.com>
Message-ID: <Pine.SGI.3.95.990121140545.7656A-100000@www.cedarnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yes, but kppp messes up the serial handshake quite badly. I don't really
know where the errors are coming from, but you could try a new (2.1.13x or
2.2.0-preX) kernel. At least one source of bad checksum packets was fixed
some time since 2.1.24

On Thu, 21 Jan 1999, j k wrote:

> The kernel is 2.1.24. Actually, if I start ppp as root from console, I
> don't see lot packets transfer. If the machine is freshly rebooted and
> I login from a regular user's X-window, using 'su -', then problem
> will come up. It seems to me the machine sends out packets and then
> the packets loop back.
> 
> The "Bad checksum" message has nothing to do with X-window.
> 
> Thanks
> 
> Jun Kong
> 
> ---Kevin Puetz <kp11901@cedarnet.org> wrote:
> >
> > What kernel? This has been resolved (though it came and went for a
> long 
> > time...) It never fully stopped networking from working, though.
> > 
> > >From: j k <j_kn@yahoo.COM>
> > >To: puetzk6715@uni.edu
> > >Subject: Re: ppp problem
> > >Date: Tue, Jan 19, 1999, 3:21 PM
> > >
> > 
> > >
> > > Thank you very much for the info, I didn't know netcfg can be used
> to
> > > set up network. I tried kppp but no luck at all so I just use the
> > > regular ppp. I guess there are some other problems with the network.
> > > It complains "bad checksum". I need to look into this when I get a
> > > chance.
> > >
> > > Thanks again
> > >
> > > Jun Kong
> > >
> > >
> > >
> > > ---puetzk6715@uni.edu wrote:
> > >>
> > >> I have never had good luck with kppp - I use netcfg, which works
> much
> > >> better.
> > >>
> > >
> 
> _________________________________________________________
> DO YOU YAHOO!?
> Get your free @yahoo.com address at http://mail.yahoo.com
> 

Kevin Puetz <kp11901@www.cedarnet.org>



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
