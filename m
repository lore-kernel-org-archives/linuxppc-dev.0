Subject: Re: unkillable zombies from using gdb and kernel 2.4.15 and higher?
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michdaen@iiic.ethz.ch>
To: Gabriel Paubert <paubert@iram.es>
Cc: Kevin Hendricks <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.33.0112102117570.24633-100000@gra-lx1.iram.es>
References: <Pine.LNX.4.33.0112102117570.24633-100000@gra-lx1.iram.es>
Content-Type: text/plain; charset=ISO-8859-1
Date: 10 Dec 2001 21:55:41 +0100
Message-Id: <1008017741.17478.34.camel@pismo>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2001-12-10 at 21:20, Gabriel Paubert wrote:
>
>
> On 10 Dec 2001, Michel [ISO-8859-1] Dänzer wrote:
>
> >
> > On Mon, 2001-12-10 at 15:11, Kevin Hendricks wrote:
> >
> > > So these zombies are ignoring kill -9  signals which I thought was a big
> > > no-no?
> >
> > Zombies are dead, they don't get more dead if you kill them. ;)
> >
> > AFAIR zombies have died but are waiting for their return value to be
> > read out of the process table. I'd like to know myself how that can
> > happen when their parents are gone...
>
> They are reparented to init. One of init tasks is to reap all
> processes who lose their parents.

So how often does it do that? Can it be beaten into submission? :)


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
