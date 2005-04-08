Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9E7F767B23
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Apr 2005 18:29:21 +1000 (EST)
Date: Fri, 8 Apr 2005 01:28:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chris Elston" <chris.elston@radstone.co.uk>
Message-Id: <20050408012855.01c99d2f.akpm@osdl.org>
In-Reply-To: <F38DEABE0E171746B133C1ABBD142D9703691AEA@radmail.Radstone.Local>
References: <F38DEABE0E171746B133C1ABBD142D9703691AEA@radmail.Radstone.Local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2.6.12-rc2 2/2] ppc32: add rtc hooks in PPC7D platform
 file
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Chris Elston" <chris.elston@radstone.co.uk> wrote:
>
>  This patch adds the hooks into the PPC7D platforms file to
>  support the DS1337 RTC device as the clock device for the 
>  PPC7D board.

The attachment has all sorts of binary microsofty gunk in it.
