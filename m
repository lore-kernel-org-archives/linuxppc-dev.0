To: Stan Partridge <SPartridge@CTDI.COM>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Unable to boot Linux 2.4.24 on a custom board similar to 8260ADS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Apr 2004 12:58:23 EDT."
             <A0CF3E6CD78CD411B369009027B0FCFE04313405@MIMIR>
Date: Tue, 20 Apr 2004 23:39:51 +0200
Message-Id: <20040420213956.DE9BEC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A0CF3E6CD78CD411B369009027B0FCFE04313405@MIMIR> you wrote:
>
> My question is how do I make the above corresponding changes above to Linux?

Only the mapping of the IMMR must be identical, and the bd_info structure.

> When I attempt to boot linux it appears to hang in the function
>
>   __delay in entry.S

Did you make sure that clocks_in_mhz is unset in your U-Boot environ-
ment? And did you really make sure that U-Boot and Linux use the SAME
bd_info structure? My guess is your clock frequencies might be wrong.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every solution breeds new problems.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
