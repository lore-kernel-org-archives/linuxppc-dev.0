Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 8DADDDDE36
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 07:50:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b2so48679ana
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Nov 2007 12:50:36 -0800 (PST)
Message-ID: <fa686aa40711081250r6b5c4590h19ba04ec44b3eaf1@mail.gmail.com>
Date: Thu, 8 Nov 2007 13:50:36 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: use of fsl, in lite5200b.dts in git current
In-Reply-To: <9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071355l75da5444kb7082692f1bdc0@mail.gmail.com>
	<4732396D.4040904@genesi-usa.com>
	<9e4733910711071418u5914f188nffc7ab50e62cc88e@mail.gmail.com>
	<9e4733910711081240l458a5e7h4898fb12e511f29a@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/8/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> No one has answered this yet. It makes no sense at all to mix use of
> the vendor prefix on some compatible entries and not on others. The
> syntax of compatible entries needs to be consistent.

The 5200 binding is poorly done on this point.  I've got a patch that
adds the 'fsl,' prefix so that future 5200 device trees are consistent
with the recommended practices (while not breaking older boards of
course)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
