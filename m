Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpxTT2tM0zDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 17:29:01 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 19 Apr 2016 17:28:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 866772CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 17:28:56 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3J7SmiN10486228
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 17:28:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3J7SN38031169
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 17:28:24 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, benh <benh@kernel.crashing.org>,
 gwshan <gwshan@linux.vnet.ibm.com>,
 linux-pci <linux-pci@vger.kernel.org>, paulus <paulus@samba.org>,
 mikey <mikey@neuling.org>,
 "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 bhelgaas <bhelgaas@google.com>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Subject: Re: [PATCH v5] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
In-reply-to: <1460670924-16845-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1460670924-16845-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Date: Tue, 19 Apr 2016 17:27:57 +1000
Message-Id: <1461050766-sup-136@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for addressing my feedback :)

Reviewed-by: Ian Munsie <imunsie@au1.ibm.com>
