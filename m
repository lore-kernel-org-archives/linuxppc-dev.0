Message-Id: <200008241552.QAA08359@hyperion.valhalla.net>
Date: Thu, 24 Aug 2000 16:52:47 +0100
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Henry Worth <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Henry,

> However, on the Pismo it looks like that in additional to the LE
> modes not being set, as previously discussed, the 8bit mode and rate
> parms are also not getting set in the Screamer. The RAW_AFMT_S8_S_44K
> sample sounds like Alvin and the Chipmonks and the lower rate samples
> are just high-speed jibberish. Here's the stest ouput for a couple:

The rate, mode and so is all done in software by the dmasound driver.  The
only hardware assists are: different sample rates (where supported) and
LE/BE swapping.

Oops, my stest instructions were not good enough - you need to tell stest
what the format of the file is:  **It does not look at *any* header
information**

./stest with no params will give you all the options.


>  [henry@osprey stest]$ ./stest -f AFMT_S16_LE_S_44K.wav

./stest -b16 -s -B -r 44100 -f  AFMT_S16_LE_S_44K.wav

(IIRC) would be right here...

and so on...

Sorry, I'll update the web page to point this out.

ciao,
Iain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
