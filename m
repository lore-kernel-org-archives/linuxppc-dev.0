Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 1CB89DE81A
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 03:16:38 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so5897062wfg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:16:37 -0700 (PDT)
Date: Mon, 28 Jul 2008 11:16:34 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: "Sparks, Sam" <SSparks@aclaratech.com>
Subject: Re: mpc8349-mITX DTB load failure
Message-ID: <20080728171634.GB21265@secretlab.ca>
References: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6011A7C9CD0EE74792C3ED2A8355608634213E@mail.twacs.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 11:10:47AM -0500, Sparks, Sam wrote:
> Hello All,
> 
> I am trying to boot the mpc8349-mITX board with Compact flash support,
> and am unable to boot the Linux kernel. Here is the pertinant versioning
> information:
> DTC 1.2.0-rc2-g17773b0e
> U-Boot 1.3.4-rc1-00012-g1953d12
> Linux-2.6.26-05752-g93ded9b
> 
> I've built the DTB using the following two commands - neither change the
> error I get during boot-up.
> $ ../dtc/dtc -b 0 -I dts -O dtb -R 4 -S 0x3000 -o
> /tftproot/ssparks/itx/cf2/itx.dtb -V 17
> arch/powerpc/boot/dts/mpc8349emitx.dts
> $ ../dtc/dtc -I dts -O dtb -o /tftproot/ssparks/itx/cf2/itx2.dtb
> arch/powerpc/boot/dts/mpc8349emitx.dts

Try adding "-p 0x3000" to ensure that you get padding to the blob.

g.
