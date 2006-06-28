Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7A5A467A45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Jun 2006 06:14:15 +1000 (EST)
To: Lee Revell <rlrevell@joe-job.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CROSS_COMPILE - namespace collision 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 28 Jun 2006 13:28:22 EDT."
	<1151515702.15513.40.camel@mindpipe>
Date: Wed, 28 Jun 2006 22:14:12 +0200
Sender: wd@denx.de
Message-Id: <20060628201412.769DD353D6F@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Lee,

in message <1151515702.15513.40.camel@mindpipe> you wrote:
> I have not been able to get readline 5.1 to compile with the ELDK - it

Did you read the documentation?

> I can make it work with a hack, but I thought this might be interesting
> info.

Please see section "3.7.2. Rebuilding Target Packages" in the manual,
http://www.denx.de/wiki/view/DULG/ELDKRebuildingComponents#Section_3.7.2.

It describes clearly what needs to be done to build target  packages.
Also  note  that  readline  already comes as part of the ELDK, so you
probably might just use the existing code.

Please RTFM.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Sometimes a feeling is all we humans have to go on.
	-- Kirk, "A Taste of Armageddon", stardate 3193.9
