Message-ID: <3957DFF4.CAD11CD2@netx4.com>
Date: Mon, 26 Jun 2000 18:57:56 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Gould, Rick" <RGould@placethecall.com>
CC: linuxppc-embedded@lists.linuxppc.org, mmporter@home.com
Subject: Re: glibc patch question and error help for building ppc cross compiler
References: <7BFFD4ADC5D1D3119808009027B21AB51BD2C6@MAIL1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Gould, Rick wrote:
>
> I'm trying to build a cross-development tool chain for building under Red
> Hat Linux 6.2 on an x86 platform targeting a Brignt Star Engineering MPC-823
> PowerPC-based board.


Unless you really want to build the tools yourself, you can download
the 8xx CDK from MontaVista (www.mvista.com).  It has the tools,
libraries, applications, and NFS diskless image for cross development
on that host environment.  The BSE-IP is supported in that package,
you just need to manually configure it (use the EP RPX-Lite as a
starting point).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
