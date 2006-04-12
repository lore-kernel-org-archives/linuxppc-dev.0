Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 1EF7867C3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 03:01:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: question about Linux 2.6 with Xilinx ML-403
Date: Wed, 12 Apr 2006 09:49:10 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871044F9E54@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant,

I know I could probably figure this out by looking at the GIT tree
directly (which I'm planning to do) but could you summarize how much
(which devices) of the ML-403 is supported by your patches?

Serial? (which Xilinx core)

Ethernet? (Hard-Core PLB TEMAC?, Soft-Core PLB EMAC? Localink TEMAC? Is
10/100/1000 supported, or is there only 1 rate e.g. 1000 supported?)

Anything else (GPIO buttons/switches?)

Thanks,
Tim

-----Original Message-----
From: linuxppc-embedded-bounces+tmartin=3Dviasat.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+tmartin=3Dviasat.com@ozlabs.org] On
Behalf Of Grant Likely
Sent: Tuesday, April 11, 2006 9:05 PM
To: yding
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: question about Linux 2.6 with Xilinx ML-403

On 4/11/06, yding <yding@lnxw.com> wrote:
>  I just checked out Linus's GIT tree from
>
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> linux-2.6.
>
>  Where is the location for Paul's GIT tree ? Just curious ...

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 399-0195
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
