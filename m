Date: Mon, 12 Jun 2000 22:14:27 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Michel Lanners <mlan@cpu.lu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: keyboard under XF4?
In-Reply-To: <200006121044.MAA03026@piglet.grunz.lu>
Message-ID: <Pine.LNX.4.21.0006122201110.22183-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 12 Jun 2000, Michel Lanners wrote:

>
> Hi list,
>
> This might not really be a -dev issue, but I need help anyway ;-)
>
> I've set up my swiss-french keyboard under XF4; works partly...
>
> What doesn't work is characters I need to type with the <alt> modifier;
> they somehow get 0x80 added to the keysym before it is delivered to an
> app.
>
> xev shows the correct charcter map, keysym etc. However, it's wrong once
> it appears in eg. an xterm: hitting <alt>3 should produce '#' (keysym
> 0x23), but in xterm the result is '£' (keysym 0xa3).
>
> Any idea? FWIW, I'm using xmodmap to set the mapping under X. Also,
> console is OK, so it's really an X issue...
>

  Can you send me the xmodmap file so i can look at it ? it might be a
problem in xf4 the 0x80 sounds very strange...

   Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
