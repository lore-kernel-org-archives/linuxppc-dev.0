Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 06F722BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 11:33:24 +1100 (EST)
To: "Andrew Dennison" <andrew.dennison@motec.com.au>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 14 Dec 2004 10:48:11 +1100."
	<002a01c4e16e$34451010$4000a8c0@CAT>
Date: Tue, 14 Dec 2004 01:32:56 +0100
Sender: wd@denx.de
Message-Id: <20041214003301.2CC13C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 and PCI1520 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Andrew,

in message <002a01c4e16e$34451010$4000a8c0@CAT> you wrote:
> 
> I posted a question on cardbus with the 5200 a few weeks ago but got no
> reply. I think the reason is that cardbus / pcmcia support may not have
> been considered when the 5200 PCI memory map was laid out, but I would
> love to be contradicted!

I think I can confirm that this was not considered, but I'm not  sure
that this is an issue here.

> I also have a few outstanding issues that I haven't resolved yet, hence I
> haven't posted a full patch, but I can now load and configure a wireless
> ethernet card. Loading cardbus drivers currently fails when accessing PCI
> configuration space on the cardbus bus, and I haven't sorted this out yet.

I'd like to see your patch (even if preliminary).

> Part of the reason for my reply is also to check if my current approach
> (remapping the PCI address space) is sane - comments anyone? I have made
> similar changes in u-boot and can now read / write CF cards so it seems
> like the right approach for the kernel too.

Unfortunately I don't have any hardware yet with  a  working  cardbus
interface. But this might change soon...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Men don't talk peace unless they're ready to back it up with war.
	-- Col. Green, "The Savage Curtain", stardate 5906.4
