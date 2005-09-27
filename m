Return-Path: <panto@intracom.gr>
Message-ID: <4339161D.4010607@intracom.gr>
Date: Tue, 27 Sep 2005 12:51:25 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
References: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>	<20050927082324.GA11437@lst.de>	<17209.817.732159.375607@cargo.ozlabs.ibm.com>	<43390DDC.7090701@cs.helsinki.fi>	<4339104E.7050705@intracom.gr>
	<17209.5879.121421.718258@cargo.ozlabs.ibm.com>
In-Reply-To: <17209.5879.121421.718258@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Heikki Lindholm <holindho@cs.helsinki.fi>,
	linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Pantelis Antoniou writes:
> 
> 
>>Count me in too; using a 970 in 32 bit mode, because of gentoo X.org
>>problems in 64 bit mode.
> 
> 
> I'm using an X.org server on a ppc64 kernel, and it all works,
> including DRI.  Both 32-bit and 64-bit X server and clients work.  We
> now have the 32-bit ioctl compatibility sorted out in the kernel DRM.
> So I don't think X is a reason to run a 32-bit kernel any more.
> 
> What X.org problems do you see with a 64-bit kernel?
> 
> Paul.
> 
> 
> 

I didn't really tried a very recent kernel, I tried it about a month ago,
and it didn't work. Could be a gentoo problem for all I know.

Since I don't have time to debug these kind of problems, it's really nice
to know that it now works :).

No worries then.

Regards

Pantelis
