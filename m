Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B10AAB6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Nov 2009 17:31:22 +1100 (EST)
Message-ID: <4AF3BCC4.6070702@nortel.com>
Date: Fri, 06 Nov 2009 00:05:56 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: DMA to User-Space
References: <BB99A6BA28709744BF22A68E6D7EB51F0330F9DC29@midas.usurf.usu.edu>	<4AF0E4A0.30802@windriver.com>	<BB99A6BA28709744BF22A68E6D7EB51F03310302E2@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F033103030E@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F033103030E@midas.usurf.usu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Bo.Liu@windriver.com" <Bo.Liu@windriver.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/04/2009 11:50 AM, Jonathan Haws wrote:

> One more question about this approach: does the mmap() call prevent
> the kernel from using this memory for other purposes?  Will the
> kernel be able to "move" this memory elsewhere?  I guess what I am
> asking is if this memory is locked for all other purposes?

You've allocated the memory in the kernel and mapped it to userspace.
If the kernel uses that memory for anything else it will be visible to
userspace.

Chris
