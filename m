Return-Path: <glikely@secretlab.ca>
Date: Wed, 17 Sep 2008 02:25:28 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: powerpc405 versus powerpc440
Message-ID: <20080917092528.GA7572@secretlab.ca>
References: <m28wu8f753.fsf@ohwell.denx.de>
	<90069.85628.qm@web23105.mail.ird.yahoo.com>
	<0F3B2CB6574F1A488E62523706BF8A7703F29826@LOUMLVEM03.e2k.ad.ge.com>
	<20080904150725.GE2479@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080904150725.GE2479@yoda.jdub.homelinux.org>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: "Wood, Robert \(GE EntSol,
	Intelligent Platforms\)" <robert.wood@gefanuc.com>,
	Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 11:07:25AM -0400, Josh Boyer wrote:
> On Thu, Sep 04, 2008 at 09:28:01AM -0400, Wood, Robert (GE EntSol, Intelligent Platforms) wrote:
> >We are migrating to the Xilinx Virtex 5 devices and that means migrating
> >our embedded software from the PowerPC405 to PowerPC440.
> >
> >Are there any gotchas we should be aware of, or will this be simple case
> >of S/W migration :-)
> 
> Erm.  405 and 440 have entirely different MMUs.  405 has real-mode, and 440
> is BookE and therefore has the MMU always on.
> 
> That is mostly an impact to the kernel itself and not to userspace.  But it
> can be annoying if you aren't used to dealing with BookE style CPUs.

As Josh said, the MMUs are entirely different, but it is mostly isolated
to impacting the kernel.  The mainline kernel already has basic support
for the Virtex5 440 in the latest release.  Also, the xilinx git server
(git.xilinx.com) has a tree with drivers for a bunch of the xilinx
devices that aren't quite ready for mainline yet.

g.
