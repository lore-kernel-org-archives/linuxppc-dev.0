From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: "'Andrey Volkov'" <avolkov@varma-el.com>,
	"'Sylvain Munaut'" <tnt@246tnt.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Re[2]: mpc5200 and ddr
Date: Thu, 26 Aug 2004 10:55:41 +1000
Message-ID: <001e01c48b07$68c32d30$ee00a8c0@CAT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1134038006.20040825205207@varma-el.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Andrey Volkov wrote:
>
> Hello Sylvain,
>
> Wednesday, August 25, 2004, 8:35:25 PM, you wrote:
>
> > Hi,
>
> > Sorry I don't have informations, but I'm interested too ;)
>
> > I guess you just "connect" them, but I wonder about
> terminations ? ( or
> > maybe keeping short trace is ok ? ).
>
>
> Certainly - termination, time diagrams, restrictions (especially
> capacitors length and likewise) etc. As I wrote before
> datasheet very foggy and miserly, but may be David or
> somebody from freescale
> enlighten me, if so, then I send info to ml.
>

Hello Andrey, Sylvain,

Micron have a tech note (TN4606) on DDR termination for point-to-point
systems. Have a look at this if you are working on a design with DDR chips
on the PCB. It appears that series termination is sufficient with short
(<50mm) track lengths. However DDR timing requires some careful attention
to layout (impedence control and track length matching) so all the
information I have found on DDR is always qualified by "simulate your
design".

My local Freescale FAE was able to supply some additional information so
maybe you can ask yours?

Andrew


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
