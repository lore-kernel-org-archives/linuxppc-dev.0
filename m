Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EFD2F67B31
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 00:03:35 +1100 (EST)
To: David Hawkins <dwh@ovro.caltech.edu>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Feb 2006 22:03:10 PST."
	<43ED7E1E.2030700@ovro.caltech.edu>
Date: Sat, 11 Feb 2006 14:03:32 +0100
Sender: wd@denx.de
Message-Id: <20060211130332.4581235262C@atlas.denx.de>
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

In message <43ED7E1E.2030700@ovro.caltech.edu> you wrote:
> 
> What MPC834x development kit are you using? What would you recommend?

We use (*) the TQM834x modules (with a STK83xx/85xx starter kit).

(*) "use" means that we ported U-Boot and Linux for it.

>   - I'd like to get a board in a PCI or cPCI-form factor, since
>     I could use it as a PCI agent/peripheral

Both PCI and cPSI are present on the STK83xx board.

>   - I'd really like to get access to the external bus
>     too.

Available on headers, too

Feel free to contact me for details.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To know how another being, another creature feels -  that  is  impos-
sible.                  - Terry Pratchett, _The Dark Side of the Sun_
