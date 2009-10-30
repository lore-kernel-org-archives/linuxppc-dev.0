Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (mail2.gnudd.com [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3A8DB7C3B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 02:09:19 +1100 (EST)
Date: Fri, 30 Oct 2009 16:08:55 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: Jonathan.Haws@sdl.usu.edu
Subject: Re: Accessing flash directly from User Space [SOLVED]
Message-ID: <20091030150855.GA15046@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu >
References: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<20091029233038.GA21587@b07421-ec1.am.freescale.net>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E230FC@midas.usurf.usu.edu>
	<200910301556.11349.mb@bu3sch.de>
Cc: scottwood@freescale.com, bgat@billgatliff.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> asm("eieio; sync");

Hmm...
	: : : "memory"

And, doesn't ";" start a comment in assembly? (no, not on powerpc it seems)

Just to make sure, if you replace msync() with another system call,
like "kill(1, 0);" you can verify wether it's really useful or if it's
only acting as a barrier.

/alessandro
