Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0FDDFB6F06
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jun 2010 14:59:03 +1000 (EST)
Date: Mon, 28 Jun 2010 00:59:00 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: section .data..init_task
Message-ID: <20100628005900.28d4a8e0@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anybody else seeing these messages?

ppc_4xxFP-ld: .tmp_vmlinux1: section .data..init_task lma 0xc0374000 overlaps previous sections
ppc_4xxFP-ld: .tmp_vmlinux2: section .data..init_task lma 0xc03a2000 overlaps previous sections
ppc_4xxFP-ld: vmlinux: section .data..init_task lma 0xc03a2000 overlaps previous sections

Or does anybody know what they mean? They started showing up in 2.6.35.

Very easy to reproduce, so don't hesitate to ask for more info.

Cheers,
   Sean
