Subject: Re: Porting LinuxPPC
To: Daniel.Wu@alcatel.com.au (Daniel Wu)
Date: Fri, 19 May 2000 18:19:51 +1000 (EST)
Cc: greyham@research.canon.com.au (Graham Stoney),
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <00May19.180925est.115223@border.alcanet.com.au> from "Daniel Wu" at May 19, 2000 06:09:22 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000519081951.BBCBB3C971@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel Wu writes:
> I think I'm missing something fundamental here ... any suggestions.

Have you checked that your BDM configuration file is disabling the watchdog
when releasing the board from reset?

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
