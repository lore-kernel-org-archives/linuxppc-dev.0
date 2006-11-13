Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BC12A67E1A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 09:27:27 +1100 (EST)
To: Roland Dreier <rdreier@cisco.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] [POWERPC] Add support for Rev. B of PowerPC 440SPe 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Nov 2006 09:55:53 PST."
	<adalkmf44eu.fsf@cisco.com>
Date: Mon, 13 Nov 2006 23:27:25 +0100
Sender: wd@denx.de
Message-Id: <20061113222725.1A79A353B4D@atlas.denx.de>
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

In message <adalkmf44eu.fsf@cisco.com> you wrote:
> This is mostly updating the PCI Express code to work with the new core
> in the Rev. B chip, which unfortunately has different undocumented
> restrictions on the PLB addresses that can be used from the Rev. A core.
> 
> Also, when adding the cputable entry for 440SPe Rev. B, we need to
> adjust the entry for 440SP Rev. A so that it looks at more bits of the
> PVR.  The 440SPe Rev. B has PVR 53421891, which would have matched the
> old 440SP pattern of 53xxx891.
> 
> Signed-off-by: Roland Dreier <rolandd@cisco.com>

Just for the record:

This patch is _heavily_ borrowed on code by Rafal Jaworowski; see
http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git;a=commit;h=30e3e3be8863902f508af74fdc61ec9b80756bc0

Please add correct attribution.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"In Christianity neither morality nor religion come into contact with
reality at any point."                          - Friedrich Nietzsche
