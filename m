Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15B542BDB6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 02:36:07 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0410081124070.13521@dell.enoriver.com>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<11BB7E60-193F-11D9-9299-003065F9B7DC@embeddededge.com>
	<Pine.LNX.4.60.0410081124070.13521@dell.enoriver.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <69EFD370-1948-11D9-9299-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 8 Oct 2004 12:37:58 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 8, 2004, at 11:38 AM, Robert P. J. Day wrote:

> i have no problem with that.  my point was that what are currently 
> potentially confusing config menus should be made *simpler*.

Thanks.  Just do it as I described.  Keep the configuration scripts 
localized
under the arch/ppc/cpm* directories.


	-- Dan
