Message-ID: <19990121195124.20532.rocketmail@send204.yahoomail.com>
Date: Thu, 21 Jan 1999 11:51:24 -0800 (PST)
From: j k <j_kn@yahoo.com>
Subject: Re: ppp problem
To: Kevin Puetz <kp11901@cedarnet.org>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The kernel is 2.1.24. Actually, if I start ppp as root from console, I
don't see lot packets transfer. If the machine is freshly rebooted and
I login from a regular user's X-window, using 'su -', then problem
will come up. It seems to me the machine sends out packets and then
the packets loop back.

The "Bad checksum" message has nothing to do with X-window.

Thanks

Jun Kong

---Kevin Puetz <kp11901@cedarnet.org> wrote:
>
> What kernel? This has been resolved (though it came and went for a
long 
> time...) It never fully stopped networking from working, though.
> 
> >From: j k <j_kn@yahoo.COM>
> >To: puetzk6715@uni.edu
> >Subject: Re: ppp problem
> >Date: Tue, Jan 19, 1999, 3:21 PM
> >
> 
> >
> > Thank you very much for the info, I didn't know netcfg can be used
to
> > set up network. I tried kppp but no luck at all so I just use the
> > regular ppp. I guess there are some other problems with the network.
> > It complains "bad checksum". I need to look into this when I get a
> > chance.
> >
> > Thanks again
> >
> > Jun Kong
> >
> >
> >
> > ---puetzk6715@uni.edu wrote:
> >>
> >> I have never had good luck with kppp - I use netcfg, which works
much
> >> better.
> >>
> >

_________________________________________________________
DO YOU YAHOO!?
Get your free @yahoo.com address at http://mail.yahoo.com


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
