Subject: Re: iBook G3: status of 2.6.5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gioele Barabucci <dev@gioelebarabucci.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <c4c2si$dv7$1@sea.gmane.org>
References: <c4c2si$dv7$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1080687801.13152.56.camel@gaston>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 09:03:21 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-03-31 at 01:18, Gioele Barabucci wrote:
> Hi,
>
> I would like to switch my iBook G3 from linux 2.4 to 2.6.
> Will there be something missing from 2.6.5 that I'm going to need?
>
> Will my CPU fan start when is too hot?

This should be hardware driven.

> Is my iBook going to sleep on low battery/lid close if I install
> pmud/pbbuttonsd?

Yes

> Is my radeon M6 supported? With DRI?

Yes.

> Are sungem eth and airport working?

Yes.

> Is there a working ALSA driver or I have to use the OSS one?

I'm not sure how well the Alsa driver will work, it works pretty badly
for me on the tipb 1Ghz, though the dmasound (oss) one works fine.

> Have USB any issue?

Not that I know

> Will HFS+ kernel module trash my OS X partition?

Heh, good question :) AFAIK, the 2.6 one won't, but I admit I don't it
much more than for reading MP3s out of my ipod ... :)

> (Is UML going to work?)

Never tried.

> Thanks for the support!
>
> --
> Gioele
>
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
