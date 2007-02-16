Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 390EBDDF55
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 03:06:52 +1100 (EST)
To: "Edward Jubenville" <edjubenville@adelphia.net>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Finding devices with dynamic IP addresses 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 12 Feb 2007 07:49:32 PST."
	<GPECLCIGPLHEOMGPMCPACELEEGAA.edjubenville@adelphia.net>
Date: Fri, 16 Feb 2007 17:06:48 +0100
Sender: wd@denx.de
Message-Id: <20070216160648.33DE6352629@atlas.denx.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <GPECLCIGPLHEOMGPMCPACELEEGAA.edjubenville@adelphia.net> you wrote:
> 
> My network will contain several ELDK-based devices configured with dynamic
> IP addresses (DHCP).  I need a way for any Windows PC on the subnet to
> locate the devices without prior knowledge of their IP address.  I'm hoping
> to find a peer-to-peer
> solution that doesn't involve a third party (DNS) server.

Assign names and use a name server?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Ada is PL/I trying to be Smalltalk.                 - Codoso diBlini
