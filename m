Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 7F5CF67C51
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 01:59:39 +1000 (EST)
Date: Tue, 17 Oct 2006 17:59:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.19-rc2: known unfixed regressions (v2)
Message-ID: <20061017155934.GC3502@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
	Thierry Vignaud <tvignaud@mandriva.com>,
	Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Jens Axboe <jens.axboe@oracle.com>, linux-visws-devel@lists.sf.net,
	Greg Banks <gnb@melbourne.sgi.com>,
	Patrick Jefferson <henj@hp.com>, Meelis Roos <mroos@linux.ee>,
	Christian <christiand59@web.de>, art@usfltd.com,
	linux-acpi@vger.kernel.org, Alan Cox <alan@redhat.com>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Ingo Molnar <mingo@elte.hu>, jgarzik@pobox.com,
	Martin Lorenz <martin@lorenz.eu.org>, len.brown@intel.com,
	Olaf Hering <olaf@aepfle.de>, discuss@x86-64.org,
	cpufreq@lists.linux.org.uk, Alex Romosan <romosan@sycorax.lbl.gov>,
	Kenny Graunke <kenny@whitecape.org>, James.Bottomley@HansenPartnership.com,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-ide@vger.kernel.org, pazke@donpac.ru,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	davej@codemonkey.org.uk, Mark Langsdorf <mark.langsdorf@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known unfixed regressions in 2.6.19-rc2 compared 
to 2.6.18 that are not yet fixed Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ppc prep boot hang
References : http://lkml.org/lkml/2006/10/14/58
Submitter  : Meelis Roos <mroos@linux.ee>
Status     : unknown


Subject    : X60s: BUG()s, lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : unknown


Subject    : T60 stops triggering any ACPI events
References : http://lkml.org/lkml/2006/10/4/425
             http://lkml.org/lkml/2006/10/16/262
Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
Status     : unknown


Subject    : x86_64: build error: unknown pseudo-op: `.cfi_signal_frame'
References : http://lkml.org/lkml/2006/10/16/8
Submitter  : Ingo Molnar <mingo@elte.hu>
Caused-By  : Jan Beulich <jbeulich@novell.com>
             Andi Kleen <ak@suse.de>
             commit adf1423698f00d00b267f7dca8231340ce7d65ef
Status     : Jan: That is nothing I added, I suppose Andi did.
                  But the fix is obvious and trivial.


Subject    : undefined reference to highest_possible_node_id
References : http://lkml.org/lkml/2006/9/4/233
             http://lkml.org/lkml/2006/10/15/11
Submitter  : Olaf Hering <olaf@aepfle.de>
Caused-By  : Greg Banks <gnb@melbourne.sgi.com>
             commit 0f532f3861d2c4e5aa7dcd33fb18e9975eb28457
Status     : unknown


Subject    : many ARM compile failures after the post -rc1 IRQ patches
References : http://lkml.org/lkml/2006/10/15/29
             http://armlinux.simtec.co.uk/kautobuild/2.6.19-rc2/index.html
Submitter  : Russell King <rmk+lkml@arm.linux.org.uk>
Caused-By  : David Howells <dhowells@redhat.com>
Status     : unknown


Subject    : CONFIG_X86_VOYAGER=y, CONFIG_SMP=n compile error
References : http://lkml.org/lkml/2006/10/7/51
Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
Caused-By  : David Howells <dhowells@redhat.com>
             commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Status     : unknown


Subject    : CONFIG_X86_VISWS=y, CONFIG_SMP=n compile error
References : http://lkml.org/lkml/2006/10/7/51
Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
Caused-By  : David Howells <dhowells@redhat.com>
             commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : SMP x86_64 boot problem
References : http://lkml.org/lkml/2006/9/28/330
             http://lkml.org/lkml/2006/10/5/289
Submitter  : art@usfltd.com
Status     : submitter was asked to git bisect
             result of bisecting seems to be wrong


Subject    : monitor not active after boot
References : http://lkml.org/lkml/2006/10/5/338
Submitter  : Olaf Hering <olaf@aepfle.de>
Caused-By  : Antonino Daplas <adaplas@pol.net>
             commit 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : ide-generic no longer finds marvell controller
References : http://bugzilla.kernel.org/show_bug.cgi?id=7353
Submitter  : Kenny Graunke <kenny@whitecape.org>
Caused-By  : Patrick Jefferson <henj@hp.com>
             commit a4bea10eca68152e84ffc4eaeb9d20ec2ac34664
Handled-By : Alan Cox <alan@redhat.com>
Status     : Alan is investigating


Subject    : cpufreq not working on AMD K8
References : http://lkml.org/lkml/2006/10/10/114
Submitter  : Christian <christiand59@web.de>
Handled-By : Mark Langsdorf <mark.langsdorf@amd.com>
Status     : Mark is investigating
