Return-Path: <olaf@ibook.aepfle.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 4051B67BE0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 23:05:44 +1000 (EST)
Date: Wed, 27 Sep 2006 15:05:25 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Use check_legacy_ioport() for ISAPnP
Message-ID: <20060927130525.GA7550@aepfle.de>
References: <1159341535.3309.108.camel@pmac.infradead.org>
	<20060927081838.GA5984@aepfle.de>
	<1159361385.3309.118.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1159361385.3309.118.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 27, David Woodhouse wrote:

> And did you fix the case of PCI parallel ports? We only want to do the
> check_legacy_ioport() thing for the 'default' built-in ports, not for
> all ports.

I have to check if my multiport IO card still works, but I'm sure it
will.
