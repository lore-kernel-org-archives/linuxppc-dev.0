Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C1B2367A83
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 22:39:44 +1000 (EST)
To: Jerome Glisse <j.glisse@gmail.com>
References: <4240b916050404033230db0551@mail.gmail.com>
	<1112618509.26086.68.camel@gaston>
	<4240b91605040412117b29d4ca@mail.gmail.com>
	<1112656372.26086.88.camel@gaston>
	<4240b91605040504525fd877e5@mail.gmail.com>
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 05 Apr 2005 14:39:36 +0200
In-Reply-To: <4240b91605040504525fd877e5@mail.gmail.com> (Jerome Glisse's
	message of "Tue, 5 Apr 2005 13:52:33 +0200")
Message-ID: <je1x9pv1mf.fsf@sykes.suse.de>
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

Jerome Glisse <j.glisse@gmail.com> writes:

> I will try t look at radeon framebuffer see if i can find anythings.
> Any idea of which change on that code may be the origin of this ?

I'd suggest looking at the changes between rc1 and rc2 first.  On my iBook
G3 with Radeon M6 I'm also having problems with rc2, whereas rc1 is
working fine.  I haven't found the time to look closer yet.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
