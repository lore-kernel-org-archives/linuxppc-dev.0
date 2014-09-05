Return-Path: <mcree@orcon.net.nz>
Received: from mail.orcon.net.nz (unknown [219.88.242.22])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 978D41A0006
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 06:46:09 +1000 (EST)
Date: Sat, 6 Sep 2014 08:42:55 +1200
From: Michael Cree <mcree@orcon.net.nz>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bit fields && data tearing
Message-ID: <20140905204255.GB4053@omega>
References: <5408E458.3@zytor.com> <54090AF4.7060406@hurleysoftware.com>
 <54091B30.2090509@zytor.com> <20140905081648.GB5281@omega>
 <20140905180950.GU5001@linux.vnet.ibm.com>
 <540A05F7.1070202@hurleysoftware.com>
 <20140905190506.GV5001@linux.vnet.ibm.com>
 <8CA974F497CA064FA9926E10ABCC061F05F97E7B77@MAILSJ4.global.cadence.com>
 <540A19B8.4010907@hurleysoftware.com> <540A1E6C.2020005@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <540A1E6C.2020005@zytor.com>
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>, David Laight <David.Laight@ACULAB.COM>,
 Peter Hurley <peter@hurleysoftware.com>, Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Marc Gauthier <marc@cadence.com>, Paul Mackerras <paulus@samba.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 05, 2014 at 01:34:52PM -0700, H. Peter Anvin wrote:
> On 09/05/2014 01:14 PM, Peter Hurley wrote:
> > 
> > Here's how I read the two statements.
> > 
> > First, the commit message:
> > 
> > "It [this commit] documents that CPUs [supported by the Linux kernel]
> > _must provide_ atomic one-byte and two-byte naturally aligned loads and stores."
> > 
> > Second, in the body of the document:
> > 
> > "The Linux kernel no longer supports pre-EV56 Alpha CPUs, because these
> > older CPUs _do not provide_ atomic one-byte and two-byte loads and stores."
> > 
> 
> Does this apply in general or only to SMP configurations?  I guess
> non-SMP configurations would still have problems if interrupted in the
> wrong place...

Yes.

Cheers
Michael.
