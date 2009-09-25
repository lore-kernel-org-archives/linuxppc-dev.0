Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D1CB9B7B8D
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Sep 2009 07:00:53 +1000 (EST)
Date: Fri, 25 Sep 2009 16:54:11 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: warning: allocated section `.data_nosave'  not in segment
Message-ID: <20090925165411.6c584401@lappy.seanm.ca>
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

Anybody else getting these? They just started popping up with the
recent changes for 2.6.32. 

ppc_4xxFP-ld: .tmp_vmlinux1: warning: allocated section `.data_nosave'
 not in segment KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
ppc_4xxFP-ld: .tmp_vmlinux2: warning: allocated section `.data_nosave' not in segment
  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
ppc_4xxFP-ld: vmlinux: warning: allocated section `.data_nosave' not in segment

Cheers,
   Sean
