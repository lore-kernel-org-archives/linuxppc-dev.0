Return-Path: <stefan.nickl@kontron.com>
Received: from kom-exchfe.kontron-modular.com (mail.e2brain.de
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 39299679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Jun 2005 18:00:42 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Vijay Padiyar <vijay_padiyar@hotmail.com>
In-Reply-To: <BAY1-DAV469FED545DEDB9CFE00498BFB0@phx.gbl>
References: <BAY1-DAV469FED545DEDB9CFE00498BFB0@phx.gbl>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 10:00:39 +0200
Message-Id: <1118044839.13965.1.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Subject: Re: STP implementation on Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2005-06-06 at 11:10 +0530, Vijay Padiyar wrote:
> Hi
> 
> I wanted to know whether the Linux 2.6 kernel has an implementation of the
> STP protocol, and if so, where can I find the relevant code.
> 
> Regards
> 
> Vijay Padiyar

Spanning tree protocol:
/usr/src/linux/net/bridge/br_stp*

-- 
Stefan Nickl
Kontron Modular Computers
