Date: Tue, 23 May 2000 20:09:41 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Sergio Brandano <sb@dcs.qmw.ac.uk>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org,
        stephan@jvc.nl
Subject: Re: Debian pmud package available 
In-Reply-To: <200005231758.SAA19464@copper.dcs.qmw.ac.uk>
Message-ID: <Pine.LNX.4.10.10005232000150.28612-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  Thank's a lot for making this package. Did you manage to contact
>  Stephan? What about the apmd patch?

Just what I needed to get half way up to speed with Debian packaging again
:-)

I've not had an answer from Stephan but I didn't give him any heads-up
either. The apmd patch seems to be included, it's enabled by the -a option
to pmud as far as I could see. The fifo (/etc/power/apm) is created
during installation, so all it should take is adding the -a to the
PMUD_FLAGS definition in /etc/default/power. I need to document this :-)

>  On testing, I'm out of business for a while, as the baby is being
>  visited by the doctor (faulty display).

Speedy recovery for the baby ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
