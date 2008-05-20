Return-Path: <ghannon@cspi.com>
Received: from orchid.cspi.com (orchid.cspi.com [192.41.172.77])
	by ozlabs.org (Postfix) with SMTP id EB239DE319
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 23:58:58 +1000 (EST)
From: ghannon@cspi.com
To: Kim Phillips <kim.phillips@freescale.com>
Message-ID: <8525744F.004ADF6D.00@pine.cspi.com>
Date: Tue, 20 May 2008 09:41:49 -0400
Subject: Re: .dtb file for mpc8641_hpcn failing on recent kernel/u-boot.
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thank-You Kim,

     That got me beyond where I was.

     It's now having problems with the SATA setup, but I will stare at
that for a while, and see if there is anything on the mailing list about
it.

     It actually made it past the PCI Scan which was one of the
key things I needed to see anyway.

Gary






Kim Phillips <kim.phillips@freescale.com> on 05/19/2008 06:03:37 PM

To:   Gary Hannon/CSP
cc:   linuxppc-dev@ozlabs.org
Subject:  Re: .dtb file for mpc8641_hpcn failing on recent kernel/u-boot.




On Mon, 19 May 2008 22:57:29 +0000 (UTC)
Gary Hannon <ghannon@cspi.com> wrote:


> Am I missing a flag on the dtc?

try adding -R 8 -S 0x3000 to the dtc command line.

Kim
