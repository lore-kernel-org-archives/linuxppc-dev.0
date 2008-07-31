Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28398DE6DD
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 02:50:02 +1000 (EST)
Message-ID: <4891ED36.9080108@freescale.com>
Date: Thu, 31 Jul 2008 11:49:58 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: - Reyneke <reynekejunk@hotmail.com>
Subject: Re: Lost time?
References: <BAY101-W540C823A709A6C5F2E815FBE7C0@phx.gbl>
In-Reply-To: <BAY101-W540C823A709A6C5F2E815FBE7C0@phx.gbl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

- Reyneke wrote:
> Anyone have any ideas, obvious suspects, or pointers where to go and look?

Check the kernel's idea of what the timebase frequency is on both kernels.

-Scott
