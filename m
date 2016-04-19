Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq5WZ0xmRzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 23:31:21 +1000 (AEST)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 19 Apr 2016 10:31:17 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 9A7EB1DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 09:31:06 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3JCUVvi9830876
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 09:30:32 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3JDVBJO021168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 10:31:11 -0300
Subject: Re: [PATCH v5] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
To: Ian Munsie <imunsie@au1.ibm.com>
References: <1460670924-16845-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <1461050766-sup-136@x230.ozlabs.ibm.com>
Cc: mikey <mikey@neuling.org>, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 gwshan <gwshan@linux.vnet.ibm.com>, paulus <paulus@samba.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 bhelgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <5716331E.80207@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 10:31:10 -0300
MIME-Version: 1.0
In-Reply-To: <1461050766-sup-136@x230.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2016 04:27 AM, Ian Munsie wrote:
> Thanks for addressing my feedback :)
>
> Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>

Thanks very much for reviewing Ian =)

Cheers,


Guilherme
