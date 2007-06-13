Return-Path: <jacmet@sunsite.dk>
Received: from smtp40.mobistarmail.be (smtp40.mobistarmail.be [193.252.23.61])
	by ozlabs.org (Postfix) with ESMTP id 27822DDD08
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 15:58:30 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf4017.mobistarmail.be (SMTP Server) with ESMTP id 4B4E17000091
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 07:58:26 +0200 (CEST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] [C67x00] Merge c67x00-hub.c into c67x00-hcd.c
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
	<11816893493783-git-send-email-grant.likely@secretlab.ca>
	<1181689350166-git-send-email-grant.likely@secretlab.ca>
	<11816893503814-git-send-email-grant.likely@secretlab.ca>
	<11816893511659-git-send-email-grant.likely@secretlab.ca>
Date: Wed, 13 Jun 2007 07:58:31 +0200
In-Reply-To: <11816893511659-git-send-email-grant.likely@secretlab.ca> (Grant
	Likely's message of "Tue, 12 Jun 2007 17:02:21 -0600")
Message-ID: <87645sieew.fsf@p4.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-usb-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> Rather than c67x00-hub.c being compiled seperately, the
 Grant> original code had c67x00-hub.c *included* by c67x00-hcd.c.
 Grant> This is a very bad idea.  Simplest solution is to merge the
 Grant> two files into one and be done with it.

Yeah, it isn't exactly pretty, but it's what the other hcd drivers do,
E.G.:

% grep -rs "include.*hub.c" *c 
ehci-hcd.c:#include "ehci-hub.c"
ohci-hcd.c:#include "ohci-hub.c"
uhci-hcd.c:#include "uhci-hub.c"

I don't quite know why they do it like that though ..

-- 
Bye, Peter Korsgaard
