Date: Thu, 6 Jul 2000 02:17:18 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: seemingly random lock-up with kernel 2.2.17p7
Message-ID: <20000706021718.A1398@thislove.dyndns.org>
References: <20000706013650.A2546@thislove.dyndns.org> <Pine.SGI.4.21.0007050845550.10655-100000@rainbow.uchicago.edu> <20000706020342.B986@thislove.dyndns.org> <396341CE.71DDB938@relog.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <396341CE.71DDB938@relog.ch>; from daenzer@relog.ch on Wed, Jul 05, 2000 at 04:10:22PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 05, 2000 at 04:10:22PM +0200, Michel Dänzer wrote:

> What versions of X are you using? Someone reported lockups with the 4.0 r128
> driver a long time ago and someone else suggested it might be bad interaction
> between the graphics and sound devices.

[gwyn@thislove:~]$ rpm -q XFree86
XFree86-3.3.6-8a

Looks like no dice there I'm afraid. I upgraded from 3.3.5-something a
week or so ago to see if that would solve it but to no avail.

--
Gwyn Judd (b.judd@xtra.co.nz)
But scientists, who ought to know
Assure us that it must be so.
Oh, let us never, never doubt
What nobody is sure about.
		-- Hilaire Belloc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
