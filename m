Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id AF1162C0082
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 23:11:15 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 27281-01 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  5 Jun 2013 14:11:11 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH] powerpc/pci: check the bus address instead of resource
 address in pcibios_fixup_resources
Date: Wed, 5 Jun 2013 14:10:45 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B726F@saturn3.aculab.com>
In-Reply-To: <1370435211-6929-1-git-send-email-haokexin@gmail.com>
References: <1370435211-6929-1-git-send-email-haokexin@gmail.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Kevin Hao" <haokexin@gmail.com>,
 "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> If a BAR has the value of 0, we would assume that it is unset yet and
> then mark the resource as unset and would reassign it later.

IIRC the PCI spec allows a BAR address of zero.
Certainly some sparc systems have assigned 0 to a BAR.
So assuming a BAR of 0 means it is unset may not be
true for all systems.

	David
