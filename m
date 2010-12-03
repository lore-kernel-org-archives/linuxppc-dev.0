Return-Path: <martyn.welch@ge.com>
Received: from exprod5og107.obsmtp.com (exprod5og107.obsmtp.com [64.18.0.184])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0EBBCB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 02:42:21 +1100 (EST)
Message-ID: <4CF90EA1.7040806@ge.com>
Date: Fri, 03 Dec 2010 15:37:05 +0000
From: Martyn Welch <martyn.welch@ge.com>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>	<201012021847.09367.dargaud@lpsc.in2p3.fr>	<1291321371.32570.415.camel@pasglop>
	<201012031558.35557.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012031558.35557.dargaud@lpsc.in2p3.fr>
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

On 03/12/10 14:58, Guillaume Dargaud wrote:
> Why is there not a word about the functions platform_*_register in my various 
> driver books ? LDD 3rd ed (O'Reilly), Writing LDD (Cooperstein) or LKD 
> (Love)... Is it something specific to powerpc and the books are oriented x86 ? 
> What's a good source, besides grepping the kernel to no end ?
> 

I have yet to find a Linux Device Driver book that isn't heavily skewed
towards x86. Some of this stuff is either specific to powerpc or
relevant a subset of non-x86 platforms.

I think Google, the linuxppc-dev mailing list, related IRC channel and
lxr.linux.no have been the sources I've mostly used learning about Linux
on powerpc.


-- 
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square,
Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
