Date: Tue, 6 Jun 2000 20:44:55 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Michel Dänzer <daenzerm@student.ethz.ch>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Francois Felix Ingrand <felix@ingrand.net>,
        Stephan Leemburg <stephan@jvc.nl>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Debian pmud package available
In-Reply-To: <39362479.BFA75F59@student.ethz.ch>
Message-ID: <Pine.LNX.4.10.10006062043470.29453-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > I already installed this version on my pismo. As far as I can tell, it
> > > only supports battery charge level on this powerbook model. Am I right?
> >
> > Yes.
>
> How? At least the gkrellm pmud plugin doesn't show the charge level here.

You need the -a flag for pmud to switch on apm support, plus the plugin
needs to read from /etc/power/apm instead from /proc somewhere.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
