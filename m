Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53488B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Dec 2009 08:21:33 +1100 (EST)
Subject: Re: xmon & SCSI ATA devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gshan <gshan@alcatel-lucent.com>
In-Reply-To: <4B3AD271.1050105@alcatel-lucent.com>
References: <4B33197D.9000506@alcatel-lucent.com>
	<1262079428.2173.218.camel@pasglop>
	<4B3AD271.1050105@alcatel-lucent.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Dec 2009 08:21:25 +1100
Message-ID: <1262121685.2173.220.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-29 at 23:09 -0500, gshan wrote:

> Actually, the situation I described above has caused lots of disk issue.
> The DPT (disk partition table) might be lost because of this. I think it's
> broken the rule: xmon is assisting to resolve kernel issue, not cause
> more.

Well, mostly xmon kicks in when you already oopsed or crashed so .. :-)

As I said, getting into the SCSI stack or similar would make the whole
thing extremely fragile. But you may want to hack something for
yourself, feel free to do so.

Cheers,
Ben.
