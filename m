Return-Path: <risto.suominen@gmail.com>
Received: from mail-ey0-f180.google.com (mail-ey0-f180.google.com
	[209.85.215.180]) by ozlabs.org (Postfix) with ESMTP id E29FBB70A3
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Dec 2010 22:27:56 +1100 (EST)
Received: by eyf18 with SMTP id 18so8531364eyf.25
	for <linuxppc-dev@ozlabs.org>; Tue, 07 Dec 2010 03:27:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1291717126.3607.17.camel@jlt3.sipsolutions.net>
References: <AANLkTinaCDvnOCy1e1Ca92hZO5UuB-9HKe4rvLg7TUEx@mail.gmail.com>
	<1291562178.3495.6.camel@jlt3.sipsolutions.net>
	<AANLkTin-wbJd6qSMnB0GL=mGL_u-cUY00pEHaWo-hpwK@mail.gmail.com>
	<1291717126.3607.17.camel@jlt3.sipsolutions.net>
Date: Tue, 7 Dec 2010 13:27:53 +0200
Message-ID: <AANLkTik=V0_2_jtQgCnE7jUh_a-Fr+JvcTqUzy1YfLKs@mail.gmail.com>
Subject: Re: PowerMac G4 (Digital Audio)
From: Risto Suominen <risto.suominen@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/12/7, Johannes Berg <johannes@sipsolutions.net>:
>
> Oh, so the change to "gpio1" was intended to be some wildcard?
>
Yes. I know, not very pretty.
>
> Can you hack the file I previously pointed out and see if that helps?
>
Well, I could try. Actually, I don't own a machine to test with.

So, as far as I can see, you don't have any special handling for this
machine, or any other either? And you don't look for these gpio15 (hp)
and gpio16 (lo). They are the detect inputs, not mute outputs. So can
they cause such problems that no sound is played? Hmm...

One solution could be to just remove the support from snd-aoa and
continue using snd-powermac. Now it's difficult because of the
auto-loading.

Risto
