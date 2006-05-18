Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25EFC67A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 22:48:28 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: PowerMac7,3 sound (was: PowerBook5,4 -- no sound?)
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
	<je1wvwfh7s.fsf@sykes.suse.de>
	<1145307118.3912.11.camel@localhost.localdomain>
	<1147862072.14395.25.camel@johannes> <je3bf85twf.fsf@sykes.suse.de>
	<1147948758.15507.52.camel@johannes>
Date: Thu, 18 May 2006 14:48:22 +0200
In-Reply-To: <1147948758.15507.52.camel@johannes> (Johannes Berg's message of
	"Thu, 18 May 2006 12:39:18 +0200")
Message-ID: <jek68jqz1l.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg <johannes@sipsolutions.net> writes:

> On Wed, 2006-05-17 at 21:32 +0200, Andreas Schwab wrote:
>
>> I have the following sound resources in /proc/iomem:
>> 
>>         80008000-800083ff : 0.00010000:i2s
>>           80008000-800083ff : Sound DMA
>>         80010000-80010fff : 0.00010000:i2s
>>           80010000-80010fff : Sound Control
>> 
>> I'm not sure whether the first mapping should be split, but I don't know
>> much about how resource mappings work.
>
> That looks like you have snd-powermac loaded

Yes, that's while I had that loaded.  Of course, I unloaded it before I
tried snd-aoa.

>> The layout id is 36, and it has both line out and headphone, detected as a
>> Snapper.
>
> Hmm. What's that again? tas3004 or 3001? I'll look at the OSX layout
> file.

I think it's a tas3004.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
