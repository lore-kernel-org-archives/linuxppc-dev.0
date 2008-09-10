Return-Path: <orutsch@sympatec.com>
Message-ID: <48C763E9.6050101@sympatec.com>
Date: Wed, 10 Sep 2008 08:06:33 +0200
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: Re: TQM8349 and ARCH = powerpc
References: <48C68763.6030606@sympatec.com>
	<20080909112253.c9c9617f.kim.phillips@freescale.com>
In-Reply-To: <20080909112253.c9c9617f.kim.phillips@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kim,

> 
> u-boot assigns the IMMR to 0xff400000 in TQM834x.h, whereas the device
> tree you picked has it at 0xe0000000 (it's defined in the soc node).
> Don't forget to match up the PCI addresses too.  patches welcome, of
> course (we don't have tqm boards).
> 
Thanks for this important information! I'll do my best to get this
kind of hardware running. Just copying the dts was a too naive
approach ;-)
Maybe I ask TQ if they want to contribute something. It would be a pity
if this module line would not be supported anymore.

Thanks and bye,

-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com
