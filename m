Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 638D3DDF63
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jun 2008 04:14:41 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so163700nfd.9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jun 2008 11:14:38 -0700 (PDT)
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: Linux on Virtex board with ARCH=powerpc
References: <4860B81F.6070205@computing.dundee.ac.uk>
	<20080624140532.E77E333006C@mail5-sin.bigfish.com>
	<48614927.8020406@computing.dundee.ac.uk>
	<20080624195027.01963640077@mail214-sin.bigfish.com>
	<48626FAC.2070904@computing.dundee.ac.uk>
	<20080625203435.D3C46778055@mail212-sin.bigfish.com>
	<48639871.9020204@computing.dundee.ac.uk>
	<20080626132905.2779E1F007F@mail24-dub.bigfish.com>
	<4864DD66.5040909@computing.dundee.ac.uk>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 27 Jun 2008 20:14:35 +0200
In-Reply-To: <4864DD66.5040909@computing.dundee.ac.uk> (Peter Mendham's
	message of "Fri\, 27 Jun 2008 13\:30\:30 +0100")
Message-ID: <874p7eeodw.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: John Linn <John.Linn@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Peter" == Peter Mendham <petermendham@computing.dundee.ac.uk> writes:

Hi,

 Peter> I now have a new and rather bizarre problem, which maybe you
 Peter> or someone else has met before.  I have a simple FPGA design
 Peter> with memory, a sysace and a uart16550 on an ML405 (I've put my
 Peter> hardware to one side for the moment).  It works just fine.  If
 Peter> I swap the uart16550 for a uartlite (remaking the kernel with
 Peter> the correct device tree) I see all the boot messages and the
 Peter> kernel seems to start OK, the root partition is mounted but
 Peter> then I see nothing from /sbin/init.  This is the same root fs
 Peter> that I was using with the uart16550 example I just mentioned.

Did you remember to change your inittab to use /dev/ttyUL0?

-- 
Bye, Peter Korsgaard
