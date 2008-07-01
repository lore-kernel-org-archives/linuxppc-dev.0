Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id D077BDDF64
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 03:07:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] powerpc: legacy_serial: reg-offset & shift aren't used
Date: Tue, 1 Jul 2008 11:07:35 -0600
In-Reply-To: <20080701170628.GA10912@secretlab.ca>
References: <12149299143952-git-send-email-john.linn@xilinx.com>
	<977C41F842E66D4CB2E41332313B6150062A2DB4@XSJ-EXCHVS1.xlnx.xilinx.com>
	<20080701165222.991255E0054@mail197-dub.bigfish.com>
	<20080701170628.GA10912@secretlab.ca>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20080701170737.D26EC1B08055@mail37-sin.bigfish.com>
Cc: Stephen Neuendorffer <stephenn@xilinx.com>, dwg@au1.ibm.com,
	linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'll respin the patch and send again.

-- John

-----Original Message-----
From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of Grant
Likely
Sent: Tuesday, July 01, 2008 11:06 AM
To: John Linn
Cc: Stephen Neuendorffer; linuxppc-dev@ozlabs.org; paulus@samba.org;
benh@kernel.crashing.org; dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc: legacy_serial: reg-offset & shift aren't
used

On Tue, Jul 01, 2008 at 10:52:20AM -0600, John Linn wrote:
> It could be "||" but I didn't know if there were cases where that
> wouldn't be true. I don't know that code that well so I was being
> conservative and maybe shouldn't be. =


No, Stephen is right.  It should be ||

g.



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
