Message-ID: <396353DD.7F1C5E7A@mondonet.net>
Date: Wed, 05 Jul 2000 17:27:25 +0200
From: Mario Scarpa <m.scarpa@mondonet.net>
MIME-Version: 1.0
To: me@johngrimes.com
CC: Gwyn Judd <b.judd@xtra.co.nz>,
        LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: seemingly random lock-up with kernel 2.2.17p7
References: <Pine.SGI.4.21.0007050940370.24528-100000@rainbow.uchicago.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


me@johngrimes.com wrote:
>
> Gwyn,
>         It does look we might have the same bug.  I'm not using XFree86-4
> either I'm also at XFree86-3.3.6-8a.  Did you say you had a rage128gl
> card?  Although I do usually have xmms open when I crash I usually am not
> playing sound so I don't think thats the problem.
>         Where can I get the latest 2.2 series kernel and more importantly,
> the latest rage128gl drivers (source off course is fine).  I use some hfs
> so I don't really want to try 2.4pre series as yet.
>         It also might be time to try Xfree86-4 (although I don't think
> this would fix it).  I really want to get multihead to work but I didn't
> have any luck with Xfree86-4 in the earlier incarnations to even get one
> monitor working.
>                                         John
> PS I am using BootX but I don't think that is the problem.


Hi there,

I've got a lombard (400MHz, 64MB) and had precisly the same
behaviour: I was playing some MP3s (mpg123 under X 3.3.6-8
debianPPC) and the system just crashed two times this morning;
coz I tried to ping it from another machine and coz I tried
to shut X down but everything was failing (definitively a system
crash I would say)...
Another brick in the wall...the MP3 I was listening this morning
where both on a CDROM and on a HD and yesterday, just doing a lot
of HD traffic (moving around some huge dirs) I had another lock;
it doesn't happen so often (would say never)...could it be something
related to the IDE driver ? Kernel here 's 2.2.17pre7 rsynced
from linuxcare.

bye,

--
Mario Scarpa

Mondonet NOC
Phone: +39 06 52.47.37.02

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
