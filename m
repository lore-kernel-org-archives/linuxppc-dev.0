Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 7EE69B7D82
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Jun 2010 07:26:58 +1000 (EST)
Message-ID: <4C11589C.7060108@harris.com>
Date: Thu, 10 Jun 2010 17:26:52 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH][RFC] ibm_newemac and SIOCGMIIREG
References: <4C10EFE0.6030106@harris.com> <201006101903.43882.arnd@arndb.de>
	<4C11414F.5070602@harris.com> <201006102235.48632.arnd@arndb.de>
In-Reply-To: <201006102235.48632.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2010 04:35 PM, Arnd Bergmann wrote:
> 
> It seems that your program is wrong. On my PC here, it also shows zero,
> while mii-tool works fine.
> 

You are correct.  I didn't realize I should embed the data
in the ifr_data area - I thought I needed to pass a pointer.

Now I see why you avoid that.  And since IFNAMSIZ is 16,
there is enough space for the struct mii_ioctl_data.  A bit
dirty, but it obviously works.

Anyway, thanks very much for taking the time to debug my
program, and set me straight.  Naturally, I withdraw the
patch. :-)

	Steve

> 
> 	Arnd
