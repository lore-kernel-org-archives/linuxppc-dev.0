Date: Wed, 17 Feb 1999 10:59:21 -0500 (EST)
From: Tom Rini <tmrini@ntplx.net>
To: Andreas Tobler <toa@pop.agri.ch>
cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: back to gcc under pre-R5
In-Reply-To: <36CA7AC0.F2F7596D@pop.agri.ch>
Message-ID: <Pine.LNX.4.05.9902171057310.980-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Feb 1999, Andreas Tobler wrote:

> is it possible to get back to gcc under pre-R5? If so. where can I get the (S)RPMS?

Erm, gcc 2.7.2.3?  You could, but that's more buggy then egcs. :)

> And how much do it affect when I build the libstdc++ with fno-vtable-thunks?
> Do I have to rebuild the whole system, since the new glibc needs vtables?
> It's only because egcs has bug which is for my subject killing.

What bug are you running into?  It's better to get 'em fixed now then try
to work around 'em...

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
