Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE22767A58
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 00:33:17 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Collins <paul@briny.ondioline.org>
Subject: Re: snd-aoa status update / automatic driver loading
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
Date: Fri, 19 May 2006 16:33:11 +0200
In-Reply-To: <87wtcirw0y.fsf@briny.internal.ondioline.org> (Paul Collins's
	message of "Fri, 19 May 2006 23:20:29 +1000")
Message-ID: <jemzdenkyg.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: list <linuxppc-dev@ozlabs.org>, Johannes Berg <johannes@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>,
	Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Collins <paul@briny.ondioline.org> writes:

> Johannes Berg <johannes@sipsolutions.net> writes:
>
>> On Thu, 2006-05-18 at 10:25 +0300, Eddy Petri=BAor wrote:
>>
>>> Any chance for 5,2 ? What is needed for it? Codec only?
>>
>> I don't know. If you try loading the modules, the kernel will tell you
>> something about an unhandled layout id. Alternatively, you can find the
>> layout-id file in your /proc/device-tree/ and tell me the number in it.
>> The rest I can figure out.
>
> I have a PowerBook5,4 here and I'd be happy to test support for it.
> The hardware is identified by snd-powermac as "PowerMac Snapper" and
> the layout ID appears to be "3".
>
> [briny(device-tree)] od -c pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/s=
ound/layout-id
> 0000000  \0  \0  \0   3
> 0000004

Apparently the layout-id on your system is 51 (decimal).

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
