Return-Path: <lists@gate-nine.de>
Received: from csmtp1.one.com (csmtp1.one.com [195.47.247.21])
	by ozlabs.org (Postfix) with ESMTP id 789BDB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Dec 2010 05:39:25 +1100 (EST)
Message-ID: <4CF69421.10206@gate-nine.de>
Date: Wed, 01 Dec 2010 19:29:53 +0100
From: Philipp Ittershagen <lists@gate-nine.de>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<1291205941.11595.9.camel@concordia>
	<201012011735.58769.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201012011735.58769.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/01/2010 05:35 PM, Guillaume Dargaud wrote:
> Now how do I connect the dots between the hardware definitions from the dts and 
> my driver ?

You can get the interrupt number from the dt by calling
irq_of_parse_and_map(). Be sure to pass the node of your device to this
function.

Then you have to request the interrupt by calling request_irq. This is
where you specify the interrupt handler.

> But first I'm not sure where to find the IRQ in there, and also I'm not sure if 
> reading the filesystem from a module is allowed.

Why do you want to read the file system?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkz2lCEACgkQCG4q0RxCsY4GpgCgiQFRhiF7jjhUdZcUBc4Y5ScJ
E0AAn0VxcCaVexepjrah64ZSS+Xhbed8
=h97e
-----END PGP SIGNATURE-----
