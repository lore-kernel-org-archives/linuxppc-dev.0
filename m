From: jeffk@jdkoftinoff.com
Date: Mon, 8 Apr 2002 19:24:59 -0700 (PDT)
To: Bill Fink <billfink@mindspring.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org,
	yellowdog-general@lists.terrasoftsolutions.com
Subject: Re: dmasound audio patch
In-Reply-To: <20020408215200.66aedba3.billfink@mindspring.com>
Message-ID: <Pine.LNX.4.21.0204081920400.25922-100000@jdkoftinoff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Apr 2002, Bill Fink wrote:

>
>
> I don't know that much about ALSA.  Are you basically saying that all
> audio apps should use a common userland library interface that handles
> all the gory details of audio reformatting, so that the apps themselves
> can be blithely ignorant of what's going on under the covers.  If so,
> I could agree with that.  I just want a common interface, so every audio
> app doesn't have to reinvent the wheel, and all the users don't have to
> be bit by the same kinds of bugs over and over again.
>
> I understand that ALSA is now available for PPC.  I'll have to take a
> closer look at it when I get a chance.  When do you think ALSA will be
> an integral part of the stable kernel?
>
>

I have to say that I have been very disappointed with ALSA in
general.  Documentation has been non existant, man pages completely
incorrect, buggy programs and libraries with no indication anywhere of
what is known to work and what is known not to work.  Maybe it has changed
in the last 6 months? Don't hold your breath.

BUT if there really is progress on the ALSA documentation it would be
nicer to have than the current sorry state of affairs of sound under
linux.

Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
