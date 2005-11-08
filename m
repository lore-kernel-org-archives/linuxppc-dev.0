Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 89502686AD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 07:56:44 +1100 (EST)
To: "David Jander" <david.jander@protonic.nl>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Nov 2005 20:44:30 +0100."
	<27139.213.84.146.227.1131479070.squirrel@protonic.xs4all.nl>
Date: Tue, 08 Nov 2005 21:56:42 +0100
Sender: wd@denx.de
Message-Id: <20051108205642.CE837352B33@atlas.denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <27139.213.84.146.227.1131479070.squirrel@protonic.xs4all.nl> you wrote:
>
> Needless to say, swap over nfs did never work reliably enough to even
> start compiling.

You can work around this. It's painfully slow, but it works. See
http://www.denx.de/wiki/view/DULG/SwappingOverNFS

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Only a fool fights in a burning house.
	-- Kank the Klingon, "Day of the Dove", stardate unknown
