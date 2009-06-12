Return-Path: <timur.tabi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 37693B71C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 23:54:42 +1000 (EST)
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171]) by ozlabs.org (Postfix) with ESMTP id 7EF29DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 23:54:41 +1000 (EST)
Received: by qyk1 with SMTP id 1so3207643qyk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 06:54:38 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1244791784.7172.69.camel@pasglop>
References: <1244791784.7172.69.camel@pasglop>
Date: Fri, 12 Jun 2009 08:54:38 -0500
Message-ID: <ed82fe3e0906120654m22f38569jea21dfaf9449c34c@mail.gmail.com>
Subject: Re: "next" branch update
From: Timur Tabi <timur@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 12, 2009 at 2:29 AM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> I pushed the following commits, along with merging Linus tree in today.

Is there a reason you keep ignoring my patch?

[PATCH 1/2 v9] powerpc: introduce macro spin_event_timeout()

There is PowerPC code in the ALSA tree that depends on my patch, so
that code will break if you don't push my patch upstream.

-- 
Timur Tabi
Linux kernel developer at Freescale
