Return-Path: <anton@samba.org>
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id CA4B6140093
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Apr 2014 11:54:38 +1000 (EST)
Date: Mon, 7 Apr 2014 11:54:39 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: ISA kernel modules that build and oops on ppc64
Message-ID: <20140407115439.684e6bca@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I built an allmodconfig kernel last Friday and tried inserting every module.
There were quite a few that oops because they probe ISA space.

Anton
--

Unable to handle kernel paging request for data at address 0xd0000800000001f2
NIP [d000000003f3ff98] probe_chip_type+0x244/0x11d4 [pata_legacy]

Unable to handle kernel paging request for data at address 0xd000080072656669
NIP [d000000004a23334] spk_serial_init+0x1c4/0xe98 [speakup]

Unable to handle kernel paging request for data at address 0xd000080000000201
NIP [d000000003f172a4] ns558_isa_probe+0x124/0x1034 [ns558]

Unable to handle kernel paging request for data at address 0xd000080000000266
NIP [d00000000495cbe0] mk712_init+0x14c/0x738 [mk712]

Unable to handle kernel paging request for data at address 0xd000080000000145
NIP [d000000008413a94] fdomain_is_valid_port+0xd8/0x910 [fdomain]

Unable to handle kernel paging request for data at address 0xd00008000000002e
NIP [d000000008e7ff9c] sch311x_detect+0x150/0xc70 [gpio_sch311x] 

Unable to handle kernel paging request for data at address 0xd00008000000002e
NIP [d00000000d8c4b14] detect_and_report_it87+0x148/0x1090 [parport_pc]

Unable to handle kernel paging request for data at address 0xd000080000000201
NIP [d000000005eb0f08] l4_add_card+0xec/0xa34 [lightning]

Unable to handle kernel paging request for data at address 0xd000080000000200
NIP [d00000000b69b410] com90xx_probe+0x490/0x2800 [com90xx]

Unable to handle kernel paging request for data at address 0xd00008000000002e
NIP [d0000000106b0298] wbsd_scan+0x184/0x7f8 [wbsd]

Unable to handle kernel paging request for data at address 0xd000080000000370
NIP [d000000010ff62d4] w83977af_probe+0x154/0x1fc0 [w83977af_ir]

Unable to handle kernel paging request for data at address 0xd000080000000150
NIP [d0000000112351a4] nsc_ircc_init+0x1d4/0x6d4 [nsc_ircc]

Unable to handle kernel paging request for data at address 0xd0000800000003f0
NIP [d000000011d0df54] smsc_ircc_probe+0x120/0x940 [smsc_ircc2]

Unable to handle kernel paging request for data at address 0xd0000800000003f0
NIP [d000000011b2112c] ali_ircc_init+0x264/0xe44 [ali_ircc]
