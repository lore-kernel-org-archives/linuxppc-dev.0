Date: Wed, 04 Apr 2001 10:21:52 +0100
Subject: Re: External Monitor under Pismo
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Tuomas Kuosmanen <tigert@ximian.com>,
	"E.  Jason  Stewart" <jason@openinformatics.com>
Cc: Andrew Sharp <andy@netfall.com>,
	"E.  Jason  Stewart" <jason@openinformatics.com>,
	debian-powerpc@lists.debian.org, stewart.sadler@roke.co.uk,
	linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010404092143.EFE4C2F01B@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Since I'm mirroring the LCD I only get 1024x768, and the pismo can
>> drive a 1600x1200@16 bit depth. So what needs to happen to aty128fb.c
>> to support the external monitor, and what can I do to make it happen??
>>
>
> That is beyond *me* but maybe someone else knows. I am just the artist
> dude 'round the corner who likes to hack with perl and stuff.. :-)
>
> I think there is no support for the external monitor in that sense in
> the driver. In macos it can do real dualhead, so that would be possible
> at least in theory, and it would be pretty nice. But currently I think
> the mirrored display is all we have for Pismo. Which works nice for
> projectors though.

My understanding is that it still needs adding - as a first step you need
someone who has signed the NDA to get the specs for the ATI chips... and
understands how to write X servers... ;-)

you could try asking Ani Joshi?
ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
