Message-ID: <3CC0348C.ED7E4F7C@opensource.se>
Date: Fri, 19 Apr 2002 17:15:24 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Michael Fischer <fischi@epygi.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC CONFIG_FEC_PACKETHOOK option?
References: <OEEHJMIIDJHHMFGGDNGDOENLCMAA.fischi@epygi.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Throw it away, please!

It was a hack done by people on my department when I was working
on Ericsson here in Sweden. We used it to capture packets and
forward them to a closed-source module where further processing
was made. The option should have been removed a long time ago.

I'm pretty confused about all sources and everything, if someone
would point me to what sources are affected, then I will make
some patches.

Thanks /

magnus

Michael Fischer wrote:
>
> Hello,
> just looked into the 8xx fec.c sources of 2.4.18 tree and discovered there
> is a CONFIG_FEC_PACKETHOOK option. Couldnt find any further information
> about it, not even the included linux/pkthook.h file. Has anyone more
> information what this is for? Is this outdated, not finished yet...?
>
> Thanks for any information,
> Best regrads, Michael
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
