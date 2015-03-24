Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68A841A0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:55:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 24 Mar 2015 11:55:09 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 217B12BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:55:05 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2O1suaF47251492
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:55:04 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2O1sUaE004320
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 12:54:31 +1100
Date: Tue, 24 Mar 2015 09:54:14 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH V14 17/21] powerpc/powernv: Shift VF resource with an
 offset
Message-ID: <20150324015414.GA7824@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1426820797-6267-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1426820797-6267-18-git-send-email-weiyang@linux.vnet.ibm.com>
 <1427152946.2922.3.camel@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427152946.2922.3.camel@axtens.net>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
 linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 24, 2015 at 10:22:26AM +1100, Daniel Axtens wrote:
>> +
>> +		/* Do some magic shift */
>> +		ret = pnv_pci_vf_resource_shift(pdev, pdn->offset);
>
>
>Given that you're already doing a version 15, would it be possible to
>include a more informative comment than "Do some magic shift"? Perhaps
>some of the information from your commit message?
>
>Regards,
>Daniel
>

Daniel,

Thanks for your comment, I will add more informative comment at this place.


-- 
Richard Yang
Help you, Help me
