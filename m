Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7465DE12B
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 17:22:16 +1000 (EST)
Date: Thu, 31 Jul 2008 01:21:59 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 11185] New: Device/host RESET in SCSI
Message-ID: <20080731072159.GB30534@parisc-linux.org>
References: <bug-11185-10286@http.bugzilla.kernel.org/>
	<20080730232409.81965504.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080730232409.81965504.akpm@linux-foundation.org>
Cc: cijoml@volny.cz, linuxppc-dev@ozlabs.org, linux-scsi@vger.kernel.org,
	bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 11:24:09PM -0700, Andrew Morton wrote:
> Why do you describe this regression as a powerpc problem rather than a
> scsi one?
> 
> (It could be either or both, I'm just wondering...)

This seems quite astute of the reporter.  The error messages from sym2
are consistent with an interrupt routing problem.  I have an idea for
reporting this more effectively (because this comes up every 3-6 months
or so) but testing that patch will have to wait until I'm back home.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
