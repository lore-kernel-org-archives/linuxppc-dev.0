Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qS2zp2bS8zDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Mar 2016 00:31:17 +1100 (AEDT)
Subject: [PATCH kernel] KVM: PPC: Create a virtual-mode only TCE table handlers
To: Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@ozlabs.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
References: <1458269442-24292-1-git-send-email-aik@ozlabs.ru>
 <20160318091629.GD1393@fergus.ozlabs.ibm.com> <56EBD126.6060307@redhat.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <56ED548C.20107@xenosoft.de>
Date: Sat, 19 Mar 2016 14:30:52 +0100
MIME-Version: 1.0
In-Reply-To: <56EBD126.6060307@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Just for info: I successfully tested the latest Git kernel with the 
patched PR KVM today. I booted a ubuntu MATE 16.04 LTS PowerPC live DVD 
with a virtual Power Mac G3 machine today.

Screenshot: https://plus.google.com/115515624056477014971/posts/HAuxJT4WGPr

Have a nice day.

Cheers,

Christian
