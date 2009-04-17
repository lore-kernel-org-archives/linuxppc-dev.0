Return-Path: <ilpo.jarvinen@helsinki.fi>
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10C73DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 23:07:19 +1000 (EST)
Date: Fri, 17 Apr 2009 16:02:03 +0300 (EEST)
From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
To: Michal Simek <monstr@monstr.eu>
Subject: Re: Proposed prom parse fix + moving.
In-Reply-To: <49E87D25.8090001@monstr.eu>
Message-ID: <Pine.LNX.4.64.0904171601020.10088@wrl-59.cs.helsinki.fi>
References: <49E81CED.1000704@monstr.eu>
	<fa686aa40904162344y67115e50lf48c174501120b30@mail.gmail.com>
	<49E87D25.8090001@monstr.eu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696208474-14043735-1239973323=:10088"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
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

---696208474-14043735-1239973323=:10088
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 17 Apr 2009, Michal Simek wrote:

> Grant Likely wrote:
> > On Fri, Apr 17, 2009 at 12:08 AM, Michal Simek <monstr@monstr.eu> wrote:
> >> Hi All,
> >>
> >> I have got email from Ilpo about prom_parse file.
> >> I take this file from powerpc. Who did write prom_parse file and take care about?
> > 
> > Posting to the linuxppc-dev list is sufficient to start.  There are
> > several people who may be interested.
> > 
> >> BTW: What about to move prom_parse file to any generic location as we discussed in past?
> >> Any volunteer?
> > 
> > I'm kind of working on it.  More specifically, I'm looking at
> > factoring out fdt stuff into common code (drivers/of/of_fdt.c). But I
> > haven't made a whole lot of progress yet.
> > 
> >> -------- Original Message --------
> >> Subject: [RFC!] [PATCH] microblaze: fix bug in error handling
> >> Date: Thu, 16 Apr 2009 23:05:53 +0300 (EEST)
> >> From: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
> >> To: monstr@monstr.eu
> >> CC: microblaze-uclinux@itee.uq.edu.au
> >>
> >> While some version of the patches were on the lkml I read
> >> some part of the code briefly through but my feedback got
> >> stuck into postponed emails, so here's one correctness
> >> related issue I might have found (the rest were just
> >> cosmetic things).
> >>
> >> I'm not sure if the latter return needs the of_node_put or not
> >> but it seems more likely than not.
> > 
> > Yes, it does.  This change is applicable to
> > arch/powerpc/kernel/prom_parse.c too.
> 
> ok.
> Ilpo: Can you create patch for both architectures?

Sure, but tomorrow as today is a deadline day :-).

-- 
 i.
---696208474-14043735-1239973323=:10088--
