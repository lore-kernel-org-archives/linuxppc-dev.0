Date: Thu, 24 Aug 2000 18:38:20 -0400 (EDT)
From: Henry Worth <haworth@ncal.verio.com>
To: Iain Sandoe <iain@sandoe.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
In-Reply-To: <200008241552.QAA08359@hyperion.valhalla.net>
Message-ID: <Pine.SOL.4.10.10008241833460.15454-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Aug 2000, Iain Sandoe wrote:

> Hi Henry,
>
> > However, on the Pismo it looks like that in additional to the LE
> > modes not being set, as previously discussed, the 8bit mode and rate
> > parms are also not getting set in the Screamer. The RAW_AFMT_S8_S_44K
> > sample sounds like Alvin and the Chipmonks and the lower rate samples
> > are just high-speed jibberish. Here's the stest ouput for a couple:
>
> The rate, mode and so is all done in software by the dmasound driver.  The
> only hardware assists are: different sample rates (where supported) and
> LE/BE swapping.
>
> Oops, my stest instructions were not good enough - you need to tell stest
> what the format of the file is:  **It does not look at *any* header
> information**
>
> ./stest with no params will give you all the options.
>
>
> >  [henry@osprey stest]$ ./stest -f AFMT_S16_LE_S_44K.wav
>
> ./stest -b16 -s -B -r 44100 -f  AFMT_S16_LE_S_44K.wav

                   ^ shouldn't that be -L?
>
> (IIRC) would be right here...
>
> and so on...
>
> Sorry, I'll update the web page to point this out.
>
> ciao,
> Iain
>

Opps, yes that fixes the problem, except for the LE case. BTW,
I couldn't find the awacs stuff in my last darwin xnu download,
has it moved out of the xnu projects, or did I just get lost?

Thanks,
Henry


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
