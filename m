Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E4ED67B5A
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Jul 2006 18:43:59 +1000 (EST)
Message-ID: <56306.84.135.218.136.1153039429.squirrel@secure.sipsolutions.net>
In-Reply-To: <jebqrqbxne.fsf@sykes.suse.de>
References: <20060707165207.877010000@sipsolutions.net>
	<20060707165531.206137000@sipsolutions.net>
	<jebqrqbxne.fsf@sykes.suse.de>
Date: Sun, 16 Jul 2006 10:43:49 +0200 (CEST)
Subject: Re: [PATCH 06/12] aoa: pmf gpio: report if function calling fails
From: "Johannes Berg" <johannes@sipsolutions.net>
To: "Andreas Schwab" <schwab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> This will always fire when a switch like lineout-mute does not exist,
> apparently because layout_notify does not check for that.
>
> pmf_gpio_set_lineout failed, rc: -19

Yeah, I know, I need to fix that. Unfortunately I've had corruption on my
/ and ~ filesystems so I'm a bit impaired right now, I'll send a patch to
make sure we don't touch knobs we don't have after I can fix up my
filesystem issues.

johannes
