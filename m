Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE003.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id AB465DDF0F
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 05:14:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: Question about DBCR0 initialization for 440
Date: Fri, 17 Apr 2009 12:58:49 -0600
In-Reply-To: <fa686aa40904171157x207d6493v9a37e2d8c61113d3@mail.gmail.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C0729E57E@SDCEXCHANGE01.ad.amcc.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
	<fa686aa40904171157x207d6493v9a37e2d8c61113d3@mail.gmail.com>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Message-ID: <20090417185854.EEA13308057@mail91-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks everyone, will do.

> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca]
> Sent: Friday, April 17, 2009 12:58 PM
> To: Josh Boyer
> Cc: John Linn; Tirumala Reddy Marri; linuxppc-dev@ozlabs.org; hollisb@us.=
ibm.com
> Subject: Re: Question about DBCR0 initialization for 440
> =

> Hey John
> =

> We just discussed this on IRC.  Go ahead and generate a patch to
> unconditionally turn on DBCR0[IDM] in head_44x.S.  Don't even bother
> wrapping it in an #ifdef CONFIG_somthing block.  It should be safe,
> but we'll throw it into -next and see if anyone complains.  If it does
> cause problems, then it can be reworked to something a wee bit more
> conservative.
> =

> g.
> =

> On Fri, Apr 17, 2009 at 11:22 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com>=
 wrote:
> > On Fri, Apr 17, 2009 at 11:46 AM, John Linn <John.Linn@xilinx.com> wrot=
e:
> >> Josh, any thoughts on putting this into head_44x.S?
> >
> > The code in the fsl file looks like the right solution. =A0I do have an=

> > odd question though, in that it's hard for the
> > kernel to really know if something like a BDI is running. =A0Namely,
> > that config option doesn't cover RiscWatch in an obvious manner.
> >
> > I also wonder if it's possible to have a host system be setting those
> > registers in a guest KVM system so the guest could be debugged with
> > gdb... =A0Hollis, any idea on that?
> >
> > josh
> >
> =

> =

> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
