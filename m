Date: Fri, 19 Jan 2001 02:30:29 +0000
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010119022903.3D8D02F01D@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Fri, Jan 19, 2001, Takashi Oe wrote:
> On 1/18/01 7:47 PM, Iain Sandoe wrote:
> [...]
>> ... by comparison with the large amount of other code already in there to do
>> rate expansion and compression/decompression it is a relatively small price
>> to pay for having all pmac machines behave the same...
>
> I know it's a small price, and some of those translations shouldn't be there
> either, I think.

I think we agree well on the principles.

>> ... at the next revision of the driver we could try issuing it with "16bit
>> 44k1 Signed BE" only - and see how much of the desktop world works ;-)
>
> Let's fix apps and keep the kernel lean.

---

my only justification is a case of expediency:

many apps ; one driver ; very, very few linux ppc audio developers.

---

OSS is legacy - and not well suited to expressing the PPC hardware.

I think that we should invest the littlest time in fixing legacy
  - accept that the CPU cycles have to be executed somewhere (although we
agree that should be in User mode).

So we can then apply these few developers to the future :
 - where apps will have to be expecting the translations to be carried out
in user space.
 - to solving the real problems (like making the latency sufficiently small
for professional audio work).

If and when ALSA is accepted into linux we can/will throw this current
driver away.  If it is built as a module - it has no lasting impact on the
kernel.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
