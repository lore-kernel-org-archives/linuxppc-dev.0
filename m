Return-Path: <arekm@pld-linux.org>
Received: from outgoing.smtp.agnat.pl (outgoing.smtp.agnat.pl [193.239.44.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9790C68926
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jan 2006 01:04:35 +1100 (EST)
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 001/001] PMAC HD runtime blinking control
Date: Sun, 22 Jan 2006 12:56:24 +0100
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
In-Reply-To: <20060122121907.792abc72.cedric.pradalier@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200601221256.25685.arekm@pld-linux.org>
Cc: debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 22 January 2006 03:19, Cedric Pradalier wrote:
> Hi,
>
> I've finally spend the time to mend the patch for control of
> the HD led blinking at runtime. This is a patch against
> 2.6.15

I wonder if it's also possible to disable blinking when laptop sleeps?

=2D-=20
Arkadiusz Mi=B6kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
