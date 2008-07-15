Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id BB371DE396
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:08:47 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Tue, 15 Jul 2008 17:59:44 +0200
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: 2.6.26 does not boot on Pegasos
Message-ID: <20080715155944.GA11881@iram.es>
References: <20080715100033.GA5147@iram.es> <487CC1F5.5090706@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <487CC1F5.5090706@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 04:27:49PM +0100, Matt Sealey wrote:
> If you built this kernel yourself, you need to do it from a system with
> an up-to-date binutils (2.18) otherwise, it does this.
> 

Thanks, this is likely the problem. The distribution is Debian stable 
with all security udates but the binutils are still 2.17. I was also 
wondering why the zImage was exploding from 2 to 5MB and why it spent
so much time in gzip at the end of a build.

Trying to add Lenny source does not help, bummer. Aptitude fails 
with an error message like "Dynamic MMap ran out of room".

	Regards,
	Gabriel
