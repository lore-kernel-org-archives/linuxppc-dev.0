From: Mark Clayton <clayton@shore.net>
Reply-To: clayton@shore.net
To: Dave Pegler <dwp@cambridgebroadband.com>
Subject: Re: ATM driver for 8260
Date: Sun, 4 Feb 2001 08:59:02 -0500
Content-Type: text/plain
Cc: linuxppc-embedded@lists.linuxppc.org, dwp@cambridgebroadband.com
References: <200102061511.KAA17221@northshore.shore.net> <14976.13620.587588.692077@gargle.gargle.HOWL>
In-Reply-To: <14976.13620.587588.692077@gargle.gargle.HOWL>
MIME-Version: 1.0
Message-Id: <01020409004700.06493@barharbor>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was under the impression that the 8260 and the 860 were very different.
After looking at the example code from Motorola. I'm not so sure that I
would be much help in working on it.

Much thanks,
Mark

On Tue, 06 Feb 2001, Dave Pegler wrote:
> Mark,
>
>    I've been working on a driver for the MPC860SAR (855T / 857 /
> 862SAR). It supports AAL0, AAL5, CBR and UBR and is integrated into
> linux ATM version 0.59 (so you get Q.2931, RFC1577, ILMI etc). I use
> a FADS 860 with a SAR-PHY daughter card (STM-1/STS-3c, E1/T1 and
> ATM25) as the development platform.
>
> Unfortunately its not finished yet and has quite a low throughput. I've not
> worked on it for about 3 months but hope to do so in the next few weeks.
>
> Dave.
>
> Mark Clayton writes:
>  >
>  > Is anyone aware of a linux driver for the ADS8260.  Or any 8260?
>  >
>  > Thanks,
>  > Mark
>  >
>  >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
