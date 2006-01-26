Return-Path: <pj@sgi.com>
Received: from omx1.americas.sgi.com (omx1-ext.sgi.com [192.48.179.11])
	by ozlabs.org (Postfix) with ESMTP id DF03E68A97
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 06:20:30 +1100 (EST)
Date: Thu, 26 Jan 2006 11:14:19 -0800
From: Paul Jackson <pj@sgi.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/6] {set,clear,test}_bit() related cleanup
Message-Id: <20060126111419.54b1cc56.pj@sgi.com>
In-Reply-To: <20060126161426.GA1709@elf.ucw.cz>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125112857.GB18584@miraclelinux.com>
	<20060126161426.GA1709@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, spyro@f2s.com, ak@suse.de,
	dhowells@redhat.com, linuxppc-dev@ozlabs.org, gerg@uclinux.org,
	sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	ysato@users.sourceforge.jp, takata@linux-m32r.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, torvalds@osdl.org,
	ink@jurassic.park.msu.ru, rth@twiddle.net, mita@miraclelinux.com,
	chris@zankel.net, dev-etrax@axis.com, ultralinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net,
	linux390@de.ibm.com, rmk@arm.linux.org.uk, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pavel wrote:
> cpu_set sounds *very* ambiguous. We have thing called cpusets,

Hmmm ... you're right.  I've worked for quite some time on both
of these, and hadn't noticed this similarity before.

Oh well.  Such is the nature of naming things.  Sometimes nice
names resemble other nice names in unexpected ways.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
