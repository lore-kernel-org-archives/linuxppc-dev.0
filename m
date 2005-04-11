Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mx1.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6586C67A67
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2005 08:50:04 +1000 (EST)
To: Colin Leroy <colin@colino.net>
References: <1113184854.9567.522.camel@gaston>
	<20050411101853.7f0e9385@colin.toulouse>
	<20050411194214.GE2603@ay.vinc17.org>
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 12 Apr 2005 00:49:53 +0200
In-Reply-To: <20050411194214.GE2603@ay.vinc17.org> (Vincent Lefevre's
	message of "Mon, 11 Apr 2005 21:42:14 +0200")
Message-ID: <jeekdhudwu.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Andrew Morton <akpm@osdl.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] pmac: Improve sleep code of tumbler driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vincent Lefevre <vincent@vinc17.org> writes:

> On 2005-04-11 10:18:53 +0200, Colin Leroy wrote:
>> I suppose it also fixes the occasionnal loud static noise that
>> sometimes at wakeup, for example on iBook G4s. Good :)
>
> Could this be related to this bug?
>
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=244467

I'm also hearing something like that on iBook G3, but only when setting
the input source to the microphone.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
