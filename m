Return-Path: <nzeitler@osii.com>
Received: from OSIMAIL.osii.com (mail.osii.com [208.42.8.142])
	by ozlabs.org (Postfix) with ESMTP id 2DB512BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 11:06:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 13 Dec 2004 18:06:29 -0600
Message-ID: <01C22B6B78D52B46BE3C38FB525617EF909AC8@osimail.osii.com>
From: "Zeitler, Nathan" <nzeitler@osii.com>
To: "Andrew Dennison" <andrew.dennison@motec.com.au>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lite5200 and PCI1520 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Andrew,

>Nathan,
>I posted a question on cardbus with the 5200 a few weeks ago but got no
reply. I think the reason is that=20
>cardbus / pcmcia support may not have been considered when the 5200 PCI
memory map was laid out, but I >would love to be contradicted!

This would certainly help explain some of the pain in getting it to
work.  :-/

>Which kernel are you using?

I'm using the 2.4.25 kernel from Denx also.  The version I have is a
couple months old (trying to keep from changing too many things at once!
:-)  ),but I have also tried the top-of-CVS version to no avail.  My
ELDK version is old, as explained earlier, but I'm taking steps to
change that.


>I also have a few outstanding issues that I haven't resolved yet, hence
I haven't posted a full patch, but I can=20
>now load and configure a wireless ethernet card. Loading cardbus
drivers currently fails when accessing PCI >configuration space on the
cardbus bus, and I haven't sorted this out yet.

It sounds like we're working towards the same end!  I would like to
assist in some way if possible.  I am willing to believe that remapping
the PCI bus is a possible approach, although I'd like to hear the
opinion of others as well.  Where in UBOOT did you change the PCI bus
mappings?
