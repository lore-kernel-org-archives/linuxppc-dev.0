Message-ID: <XFMail.20030822181838.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <1061556959.813.18.camel@gaston>
Date: Fri, 22 Aug 2003 18:18:38 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linuxppc-2.5 fixlets
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> ALSA does not support Mac sound chips very well yet. I also have problems
>> with a G4mdd (Snapper audio).
>
> The Alsa code base is so much cleaner that I recommend people interested
> in looking at it to work with Takashi into fixing his code base,

Is there some hw documentation ?

> there's really no point in continuing artificial life support for
> dmasound on pmac, that codebase is way to messy and confused (and
> 2.6 doesn't have the up-to-date one which is in 2.4 anyway).

Well, dmasound doesn't work at all for me, I already moved to
ALSA which is far superior than OSS.


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
