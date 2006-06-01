Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 72FE267A5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 06:32:45 +1000 (EST)
To: "Chris Dumoulin" <cdumoulin@ics-ltd.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: memset hangs part way through; called from early_init 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 01 Jun 2006 13:00:32 EDT."
	<200606011700.k51H0WJw014425@www-webmail1.magma.ca>
Date: Thu, 01 Jun 2006 22:32:43 +0200
Sender: wd@denx.de
Message-Id: <20060601203243.83B43353B06@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <200606011700.k51H0WJw014425@www-webmail1.magma.ca> you wrote:
>
> Currently, the board hangs in the early_init function. Specifically, at the following line:
> memset_io(PTRRELOC(&__bss_start), 0, _end - __bss_start);
...
> Any ideas would be appreciated.

See http://www.denx.de/wiki/view/DULG/LinuxCrashesRandomly

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A princess should not be afraid -- not with a brave knight to protect
her.
	-- McCoy, "Shore Leave", stardate 3025.3
