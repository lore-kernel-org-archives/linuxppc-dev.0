Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 0174267A6F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2005 04:50:51 +1000 (EST)
Date: Wed, 6 Apr 2005 11:50:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian <evilninja@gmx.net>
Message-ID: <20050406185049.GF3396@smtp.west.cox.net>
References: <20050328232355.GA1982@pegasos>
	<20050331142813.GH25923@smtp.west.cox.net>
	<20050331184549.GA28069@pegasos> <4251D5BA.5080905@gmx.net>
	<20050405053930.GD4604@pegasos>
	<20050405143802.GS25923@smtp.west.cox.net>
	<42533FA1.1070001@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42533FA1.1070001@gmx.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PREP sym53c8xx sym53c8xx brokeness due to
	2.6.9-rc1-bk1	introduced residual data patch ...
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2005 at 03:47:13AM +0200, Christian wrote:
> Tom Rini wrote:
> > Can either of you verify that say 2.6.11.6 w/ "noresidual" on the
> > command-line works?  Thanks.
> 
> i booted vanilla 2.6.11.6 with noresidual (and "nopresidual" too, as Sven
> sugggested), but the scsi errors did not went away :(
> 
> on a side note, and perhaps totally unrelated: i always have
> PROC_PREPRESIDUAL=y in my .config, but i never had /proc/residual as
> promised from the help text.

Odd.  I thought that only happened if you had no residual data at all
(which can happen on Powerstacks, esp if netbooting the kernel).  But in
that case the new code shouldn't be hit at all.  Leigh?

-- 
Tom Rini
http://gate.crashing.org/~trini/
