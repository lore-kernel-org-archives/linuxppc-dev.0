Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 29988DDEB6
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:15:31 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2951754wag
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 06:15:30 -0700 (PDT)
Message-ID: <fa686aa40710170615q3b69b13ch7a0038e9c6270729@mail.gmail.com>
Date: Wed, 17 Oct 2007 07:15:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Paul Mackerras" <paulus@samba.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: Merge dtc
In-Reply-To: <20071017052220.GA3801@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071016050217.GA9052@localhost.localdomain>
	<fa686aa40710160617o57564cb4r260a40cd66407852@mail.gmail.com>
	<20071017052220.GA3801@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/16/07, David Gibson <dwg@au1.ibm.com> wrote:
> On Tue, Oct 16, 2007 at 07:17:01AM -0600, Grant Likely wrote:
> > On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > This very large patch incorporates a copy of dtc into the kernel
> > > source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> > > longer an external dependency to build kernels with configurations
> > > which need a dtb file.
> >
> > Powerpc is probably not going to be the only user of dtc.  Microblaze
> > will be using it too.  Can it be put somewhere more common?
>
> Well, I guess we can move it to scripts/ when microblaze starts using
> it.
>
> Also, tell me more about this microblaze, I'm certainly interested in
> new users of dtc...

It's a 'soft processor'.  Implemented in the fabric of an FPGA.  It's
a ucLinux target.  Xilinx Virtex and Xilinx MicroBlaze targets share a
lot of common devices.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
