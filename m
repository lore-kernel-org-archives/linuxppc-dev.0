Return-Path: <schwab@suse.de>
From: Andreas Schwab <schwab@suse.de>
To: "Siva Prasad" <sprasad@bivio.net>
Subject: Re: Variable "current" in Linux kernel...
References: <D83235F0F3C86D4D889D8B9A0DA8C6D75A76F1@corpexc01.corp.networkrobots.com>
Date: Tue, 17 Apr 2007 00:53:38 +0200
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D75A76F1@corpexc01.corp.networkrobots.com>
	(Siva Prasad's message of "Mon, 16 Apr 2007 14:56:17 -0700")
Message-ID: <jeabx8exsd.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

"Siva Prasad" <sprasad@bivio.net> writes:

> I would like to know where exactly the value of variable "current" gets
> changed.

In _switch (see arch/powerpc/kernel/entry_{32,64}.S).  For ppc32, current
is always in r2.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
