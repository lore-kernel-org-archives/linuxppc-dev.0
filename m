Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTw3C4n3LzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 13:26:47 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vTw3B5vfCz9s7R
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2017 13:26:46 +1100 (AEDT)
Message-ID: <1487903189.23576.250.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/12] drm/ast: Handle configuration without P2A bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Cc: dri-devel@lists.freedesktop.org, linuxppc-dev@ozlabs.org,
 airlied@redhat.com, "Y . C . Chen" <yc_chen@aspeedtech.com>, eich@suse.come
Date: Fri, 24 Feb 2017 13:26:29 +1100
In-Reply-To: <CACPK8XfqnCm7ufoXQhvpx3tbhcoJtrtEzxJFrhmY-Q4Oif5Q_Q@mail.gmail.com>
References: <20170223225357.9572-1-benh@kernel.crashing.org>
 <20170223225357.9572-2-benh@kernel.crashing.org>
 <CACPK8XfqnCm7ufoXQhvpx3tbhcoJtrtEzxJFrhmY-Q4Oif5Q_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-24 at 12:51 +1030, Joel Stanley wrote:
> Are these properties supposed to repeat the prefix "ast,ast"?
> 
> We've chosen aspeed as the vendor prefix for Aspeed stuff.

Argh no, that's a typo... must have worked in my tests bcs
the defaults are fine. I'll update.

Cheers,
Ben.
