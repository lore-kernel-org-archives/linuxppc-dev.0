Date: Wed, 16 Aug 2000 20:03:42 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: daenzerm@student.ethz.ch
cc: MkLinux Setup List <mklinux-setup@public.lists.apple.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Xlib Question
In-Reply-To: <399A5D88.1535C44C@relog.ch>
Message-ID: <Pine.LNX.3.96.1000816200011.30198E-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 16 Aug 2000, Michel Dänzer wrote:

> "David A. Gatwood" wrote:
>
> > When I'm running a multithreaded app with heavy signal load,
>
> ...like Netscape? :)

No, my own program, but... hmm... now that you mention it.  It's
interesting that almost every problem I've found in my code has been
reported at some point as a bug in Netscape as well.  Most of them are my
errors, but it makes me feel a little better knowing that I'm not the only
one who isn't always careful about calling Xlib functions without proper
display locking.... ;-)


> > xlib messages stop being delivered from xlib to the program, resulting in
> > XNextEvent stalling.  Most of the time, if you click somewhere in that
> > window, those events all get delivered at once, sometimes twenty or thirty
> > at a time.
>
> I've noticed that Netscape often stalls up/downloads to/from the roaming
> access server. When I click into the window, it continues. Is that the problem
> you are seeing as well?

I'm actually seeing the thing not update the window, then when you click
over to another one, and click back, the thing (most of the time) updates.


> This makes me suspect the 4.0.1 server (I don't remember it happening with
> 4.0), are you using that as well?

No, using Xpmac, from 3.3.6 XFree.


David

---------------------------------------------------------------------
A brief Haiku:

Microsoft is bad.
It seems secure at first glance.
Then you read your mail.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
