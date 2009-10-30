Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E655B7C32
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 01:56:19 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Accessing flash directly from User Space [SOLVED]
Date: Fri, 30 Oct 2009 15:56:09 +0100
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<20091029233038.GA21587@b07421-ec1.am.freescale.net>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E230FC@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330E230FC@midas.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200910301556.11349.mb@bu3sch.de>
Cc: Scott Wood <scottwood@freescale.com>, Bill Gatliff <bgat@billgatliff.com>,
	Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 30 October 2009 15:50:22 Jonathan Haws wrote:
> > I suspect that the msync() was merely serving as a very heavyweight
> > memory barrier.
> 
> I did try hacking the mb() calls from the kernel source to use them in user space, but they had no effect.  I still had to include the calls to msync().

What did the resulting mb() that you used look like?

-- 
Greetings, Michael.
