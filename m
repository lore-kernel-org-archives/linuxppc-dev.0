Date: Thu, 18 Jan 2001 21:05:25 -0600
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B68D0B14.5857%toe@unlserve.unl.edu>
In-Reply-To: <20010119022903.3D8D02F01D@apollo.valhalla.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 1/18/01 8:30 PM, Iain Sandoe wrote:

> my only justification is a case of expediency:
>
> many apps ; one driver ; very, very few linux ppc audio developers.

Do you have any hard number?  How many *popular* apps does the pismo change
break?  I don't there are so many linux audio apps to begin with.

> If and when ALSA is accepted into linux we can/will throw this current
> driver away.  If it is built as a module - it has no lasting impact on the
> kernel.

I think ALSA will be in, but do you know for sure OSS will go away?
Besides, people will be using 2.4 for a long time, and I don't think OSS
will go away from 2.4 ever.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
