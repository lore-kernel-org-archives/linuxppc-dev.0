Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 96A2A67A72
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 09:25:45 +1000 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <4240b916050404033230db0551@mail.gmail.com>
	<1112618509.26086.68.camel@gaston>
	<4240b91605040412117b29d4ca@mail.gmail.com>
	<1112656372.26086.88.camel@gaston>
	<4240b91605040504525fd877e5@mail.gmail.com>
	<je1x9pv1mf.fsf@sykes.suse.de> <1112742738.9517.45.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
Date: Wed, 06 Apr 2005 01:25:40 +0200
In-Reply-To: <1112742738.9517.45.camel@gaston> (Benjamin Herrenschmidt's
	message of "Wed, 06 Apr 2005 09:12:18 +1000")
Message-ID: <jesm24x0uj.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2005-04-05 at 14:39 +0200, Andreas Schwab wrote:
>> Jerome Glisse <j.glisse@gmail.com> writes:
>> 
>> > I will try t look at radeon framebuffer see if i can find anythings.
>> > Any idea of which change on that code may be the origin of this ?
>> 
>> I'd suggest looking at the changes between rc1 and rc2 first.  On my iBook
>> G3 with Radeon M6 I'm also having problems with rc2, whereas rc1 is
>> working fine.  I haven't found the time to look closer yet.
>
> What problem specifically ?

<http://marc.theaimsgroup.com/?l=linux-kernel&m=111273873814456&w=2>

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
