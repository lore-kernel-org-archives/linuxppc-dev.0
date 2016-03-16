Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQD9x1NBFzDq70
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 01:18:44 +1100 (AEDT)
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 16 Mar 2016 11:18:40 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E0E103520077
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 10:18:26 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2GDIkvM12779820
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 10:18:46 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2GEIZhs024795
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 11:18:36 -0300
Subject: Re: [PATCH v2] powerpc/pci: Assign fixed PHB number based on
 device-tree properties
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1458082481-29916-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160316011715.GA4071@gwshan>
Cc: mikey@neuling.org, linux-pci@vger.kernel.org, paulus@samba.org,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Message-ID: <56E96B3B.50600@linux.vnet.ibm.com>
Date: Wed, 16 Mar 2016 11:18:35 -0300
MIME-Version: 1.0
In-Reply-To: <20160316011715.GA4071@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks very much for the comments Gavin! I agree with all of them, will 
rework the patch and send a new version.

Cheers,


Guilherme
