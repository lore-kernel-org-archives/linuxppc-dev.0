Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7B6BD67B50
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Jun 2005 10:53:42 +1000 (EST)
Date: Fri, 3 Jun 2005 17:53:39 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Message-ID: <20050604005339.GC12513@gate.ebshome.net>
References: <42A0E647.80604@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42A0E647.80604@am.sony.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [2/2] PM support for emac driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2005 at 04:22:47PM -0700, Geoff Levand wrote:
> This is a first attempt to add PM support to the PPC 440 emac 
> driver.  Still needed are code to take care of the PHY chip, 
> and to support wake-on-lan.  Any comments on how to do 
> those would be most welcome.

Just FYI, there are plans to get rid of the current buggy EMAC driver 
and replace it with the new NAPI one (http://kernel.ebshome.net).

-- 
Eugene
