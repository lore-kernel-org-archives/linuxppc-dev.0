From: "Calum Selkirk" <cselkirk@xs4all.nl>
Date: Sun, 27 Jul 2003 22:56:22 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: firewire in 2.4.21-ben2
Message-ID: <20030727205622.GK2278@xs4all.nl>
Reply-To: Calum Selkirk <cselkirk@xs4all.nl>
References: <Pine.LNX.4.56.0307141313050.1861@daronin.digimerc.com> <1058261452.628.36.camel@gaston> <20030717101149.GA2393@xs4all.nl> <20030726143945.GJ24614@xs4all.nl> <1059321991.529.4.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1059321991.529.4.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


* Benjamin Herrenschmidt [benh@kernel.crashing.org] [2003-07-27 12:06 -0400]:

> > OK .. attatched is a backtrace (hopefully accuratly transcribed) and
> > snippit from /var/log/messages.
> >
> > As i said previously I haven't been able to reproduce this, it's only
> > happened to me on one occassion (the above backtrace is from another
> > user/machine). Might this be related to the other ieee1394 bug, where
> > unloading ohci1394 after sleep will oops?
>
> A backtrace with just numbers is useless, you should either provide
> insmod -m output or run the oops through ksymoops.

ok, sorry. As i said this wasn't from my own machine. When it next
appears I'll run it through ksymoops (I wasn't until now aware of the
tool).

best

cal

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
