Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id D567B2BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Jan 2005 03:11:29 +1100 (EST)
To: "Rune Torgersen" <runet@innovsys.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Jan 2005 09:32:28 CST."
	<DCEAAC0833DD314AB0B58112AD99B93B85928F@ismail.innsys.innovsys.com>
Date: Wed, 12 Jan 2005 17:10:55 +0100
Sender: wd@denx.de
Message-Id: <20050112161100.62A95C108D@atlas.denx.de>
Cc: Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@ozlabs.org>
Subject: Re: Kernel boot hangs by parallel flood pings 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <DCEAAC0833DD314AB0B58112AD99B93B85928F@ismail.innsys.innovsys.com> you wrote:
> I have had the problem before (and so has several other people)
> 
> This is a reply I got on the old Linux PPC mailinglist last year
> (from Gerard Guevel [gguevel@interfaceconcept.com])

According to my records the patch was by Jean-Denis Boyer, 05 Jun
2003.

> I never saw this problem after installing this patch.

I can confirm this, too.

Steffen: this is PatchSet 251 (Date: 2004/06/07 20:05:39) in our  CVS
tree.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Yes, it's a technical challenge, and  you  have  to  kind  of  admire
people  who go to the lengths of actually implementing it, but at the
same time you wonder about their IQ...
         --  Linus Torvalds in <5phda5$ml6$1@palladium.transmeta.com>
