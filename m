Message-ID: <386BDEF1.8421A130@netx4.com>
Date: Thu, 30 Dec 1999 17:38:41 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alanm@unforgettable.com>
CC: linuxppc-embedded@lists.linuxppc.org, dclear@uswest.net
Subject: Re: Embedded planet 860T CLLF HELP!
References: <19991230.21564500@alanm.penguinpowered.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:

> I built the 2.2.13 from the source tarball, only changing .config to
> 860T CPU support,

Well, here is a lesson.  You just can't edit .config.  You have
to run 'make config', as there are more files than just .config
that have context about the kernel configuration.

You could also _ask_ before starting, as I have a ready to
go set of sources for the CLLF on my file server.  You can
use anonymous FTP to mail.netx4.com and pick up cllf-2.2.13.tgz.

I don't know how long I will keep this stuff there, but it is
there now if you want it (along with some other things).


FYI, I _really_ have the FEC driver screwed up for the CLLF, so
don't bother trying to use it.  I made lots of changes yesterday,
it still isn't perfect, and I am travelling for the next ten
days or so.  I will finish it when I return, and may have the
opportunity to work on it during my travel.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
