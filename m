Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A59B8B7B6A
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Nov 2009 08:17:01 +1100 (EST)
Subject: Re: [PATCH v3 16/27] PPC: use helpers for rlimits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Slaby <jirislaby@gmail.com>
In-Reply-To: <4B10E385.1030900@gmail.com>
References: <1259363167-9347-1-git-send-email-jslaby@suse.cz>
	<1259363167-9347-16-git-send-email-jslaby@suse.cz>
	<1259367557.2076.11.camel@pasglop>  <4B10E385.1030900@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 29 Nov 2009 08:16:03 +1100
Message-ID: <1259442963.2076.17.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, nhorman@tuxdriver.com,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, oleg@redhat.com,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, tglx@linutronix.de,
	marcin.slusarz@gmail.com, hpa@zytor.com,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	James Morris <jmorris@namei.org>, torvalds@linux-foundation.org,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-11-28 at 09:47 +0100, Jiri Slaby wrote:
> Are you sure? The previous version with ACCESS_ONCE was generally
> NACKed. This one uses a newly added helper which is much more cleaner
> way to do it.

I haven't seen a nack, but then I haven't pushed out yet so I can easily
back it off and replace it with this one.

Cheers,
Ben.
