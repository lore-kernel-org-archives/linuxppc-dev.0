Message-ID: <3925207D.B8A5792E@charter.net>
Date: Fri, 19 May 2000 06:07:41 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
CC: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting LinuxPPC
References: <20000519081951.BBCBB3C971@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
>
> Daniel Wu writes:
> > I think I'm missing something fundamental here ... any suggestions.
>
> Have you checked that your BDM configuration file is disabling the watchdog
> when releasing the board from reset?

Also check that DER is zero'd when running with the debugger.
That was my situation in some previous posts.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
