In-Reply-To: <Pine.LNX.4.10.9907021615070.17139-100000@mercator.cs.kuleuven.ac.be>
Date: Fri, 2 Jul 1999 20:04:17 +0200
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Problems with the atyfb driver on Power Mac G3
Message-Id: <19990702200417.013965@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 2, 1999, Geert Uytterhoeven
<Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

>To get maximum performance, you want a low threshold-empty value and a high
>threshold-full value, because SGRAM is optimized for burst accesses, but
has a
>high latency for the initial access. Higher threshold-empty and lower
>threshold-full values are more conservative and more likely to not
disturb the
>screen, but lower the performance.

What about providing a private ioctl to set those threshold values ? With
a simple command line tool and eventually a pair of sliders on X, this
would allow people to try out and us to collect infos about behaviour of
various values on various configurations, and eventually provide more
conservative default values, and letting the user eventually increase
performances later. 


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
