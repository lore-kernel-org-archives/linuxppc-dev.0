Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 007CBDDFB2
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 20:00:14 +1100 (EST)
Date: Fri, 10 Oct 2008 11:00:09 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC 0/6] Proposal for a Generic PWM Device API
In-Reply-To: <48EED4D1.2040506@billgatliff.com>
Message-ID: <Pine.LNX.4.64.0810101054140.12257@vixen.sonytel.be>
References: <cover.1223482372.git.bgat@billgatliff.com>
	<1223608819.8157.127.camel@pasglop>
	<48EED4D1.2040506@billgatliff.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1062284663-1223628975=:12257"
Cc: linux-embedded@vger.kernel.org,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1062284663-1223628975=:12257
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0810101057031.12257@vixen.sonytel.be>

On Thu, 9 Oct 2008, Bill Gatliff wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2008-10-08 at 11:43 -0500, Bill Gatliff wrote:
> >> This series proposes a "generic PWM" driver API.
> >>
> >> This proposed API is motivated by the author's need to support
> >> pluggable devices; a secondary objective is to consolidate the
> >> existing PWM implementations behind an agreeable, consistent,
> >> redundancy-reducing interface.
> > 
> >  .../...
> > 
> > You should send your patches to the main linux kernel list !
> 
> Perhaps.  But it seemed more relevant to this crowd, and the linux-embedded
> crowd, and the linux-arm-kernel crowd.

Were did you actually sent them to?  Apparently you sent them to each mailing
list (at least linux-embedded and linuxppc-dev) _separately_ (or using bcc).

Hence different people may give the same comments without knowing about each
other, and you may have to explain everything multiple times.

I would go for lkml and linux-embedded, _together_.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-1062284663-1223628975=:12257--
