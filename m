Date: Fri, 12 Oct 2001 05:09:17 -0700
From: Matt Porter <mporter@mvista.com>
To: mod+linuxppc-dev@mclx.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC+southbridge designs
Message-ID: <20011012050917.A15738@cx258813-a.chnd1.az.home.com>
References: <200110121337.JAA21171@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200110121337.JAA21171@missioncriticallinux.com>; from mod+linuxppc-dev@mclx.com on Fri, Oct 12, 2001 at 09:37:27AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 12, 2001 at 09:37:27AM -0400, mod+linuxppc-dev@mclx.com wrote:
>
> How many existing PPC-based machines incorporate one
> of those kitchen-sink southbridge chips like the VIA
> VT82C686B that are normally found in x86-based machines?

A lot of them.  Hardware developers for high-end PPC embedded designs
like them as a way to get UARTs, PIC, and IDE in one dirt-cheap package.
Software developers hate them because they are evil.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
