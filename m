Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60E83B6F72
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 14:12:42 +1000 (EST)
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) (authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with
	ESMTP id p4J4C8uY018146
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2011 21:12:10 -0700
Received: by ewy2 with SMTP id 2so807931ewy.15
	for <linuxppc-dev@ozlabs.org>; Wed, 18 May 2011 21:12:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1305777978.7481.37.camel@pasglop>
References: <1305777978.7481.37.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 May 2011 21:11:47 -0700
Message-ID: <BANLkTikRjqpxRKKhawcD1WjyhmH1PUgz5A@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 18, 2011 at 9:06 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Dunno if it's too late or not yet but here's 3 fixes for powerpc that
> would be welcome to have in before the release. If not I'll send them
> first thing next (one of them is already in -next in fact).

Gah. I just cut 2.6.39.

          Linus
