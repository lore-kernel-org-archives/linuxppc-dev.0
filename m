Return-Path: <Joaquin.Luna@jdsu.com>
Received: from exprod7og106.obsmtp.com (exprod7og106.obsmtp.com [64.18.2.165])
	by ozlabs.org (Postfix) with SMTP id 9E8E7DDDE0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 07:01:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC8313E RDB: Badness at fs/sysfs/dir.c:463
Date: Tue, 28 Oct 2008 12:38:04 -0700
Message-ID: <DF6C7BC3780EE44B83430A9F756D43B6081E5D5D@SJEXCH03.ds.jdsu.net>
In-Reply-To: <490739FC.6020803@freescale.com>
References: <48F49D7D.5070107@provision-comm.com>	<48F4A8CD.6000101@provision-comm.com>	<22A97B63-36D5-44BA-8F49-BAF5870FA08A@kernel.crashing.org>	<1224065185.457.31.camel@mike-linux.provision-comm.com><1225209233.937.6.camel@mike-linux.provision-comm.com>
	<490739FC.6020803@freescale.com>
From: "Joaquin Luna" <Joaquin.Luna@jdsu.com>
To: "Scott Wood" <scottwood@freescale.com>,
	"Mike Dyer" <mike.dyer@provision-comm.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having the same problem with badness at fs/sysfs/dir.c on the
MPC8313ERDB.  More importantly my custom board based on this development
board will not boot past "loading device tree."  Are there any other
mismerges in this file?  If we fix the dts file how do we fix the
official dts file and when would that fix be put in place?

- Joaquin Luna

-----Original Message-----
From: linuxppc-embedded-bounces+joaquin.luna=3Djdsu.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+joaquin.luna=3Djdsu.com@ozlabs.org] On
Behalf Of Scott Wood
Sent: Tuesday, October 28, 2008 12:13 PM
To: Mike Dyer
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8313E RDB: Badness at fs/sysfs/dir.c:463

Mike Dyer wrote:
> I believe the DMA is being added twice, because it occurs twice within
the mpc8313erdb.dts device tree.  Once by itself, and once within a
sleep-nexus.
>=20
> Is that right / normal ?

No, that looks like a mismerge.  There should only be the node under=20
sleep-nexus.

-Scott
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
