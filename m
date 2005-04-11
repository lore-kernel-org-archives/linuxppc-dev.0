Return-Path: <wd@denx.de>
Received: from mailout10.sul.t-online.com (mailout10.sul.t-online.com
	[194.25.134.21]) by ozlabs.org (Postfix) with ESMTP id 8982B67B21
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Apr 2005 17:24:16 +1000 (EST)
To: karim@opersys.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 11 Apr 2005 00:16:09 EDT."
	<4259FA09.8040508@opersys.com>
Date: Mon, 11 Apr 2005 09:24:01 +0200
Sender: wd@denx.de
Message-Id: <20050411072406.CF0F5C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x with TQM860L 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4259FA09.8040508@opersys.com> you wrote:
> 
> I've been trying to get a 2.6.x kernel working with a TQM860L board
> with little success. I can get 2.6.11.6 to boot and _sometimes_ get
> to a shell, but most of the times it dies while starting init. From
> reading the archives, this looks very much like an SDRAM config issue
> (i.e. dies mostly when bursting.) Has anyone on this list got a
> 2.6.x kernel working with the TQM860L?

No, in this case it is not a SDRAM issue. I  understand  that  you're
using U-Boot on the board, and this is one of our reference platforms
and among the best tested systems with U-Boot.

Did you apply Marcelo's patch?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Nobody goes to that restaurant anymore. It's too crowded.
