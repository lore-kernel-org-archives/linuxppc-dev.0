Date: Tue, 24 Aug 1999 11:05:26 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Dave Weis <djweis@plconline.com>
cc: Benjamin Herrenschmidt <bh40@calva.net>, Tony Mantler <eek@escape.ca>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <Pine.LNX.4.10.9908240826490.24794-100000@catbert.desm.plconline.com>
Message-ID: <Pine.LNX.3.96.990824110317.26367J-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Aug 1999, Dave Weis wrote:

> Depending on how in to the 68k boxes you are, the impression I got is that
> the memory structure is very similar to the 68ks of the same shape/era. I
> tried it on my wife's 6114CD and it hung with just the desktop background
> visible. Mix and match some of the mac68k code and you should be done in
> no time :-) haha

It's a nasty mismatch.  It's basically a Quadra 630, but with Valkyrie for
video, a few other small changes, and an added PPC to 68k bus bridge that
probably needs to have at least minimal support, and a bunch of other
oddities.  Hmmm.  That brings up another place where the code could be
going wrong.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
