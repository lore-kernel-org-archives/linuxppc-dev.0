Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4652B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 10:46:45 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 10:46:44 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AFB592CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 10:46:41 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s560kPP111927962
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 10:46:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s560keEK022310
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 10:46:41 +1000
Date: Fri, 6 Jun 2014 10:46:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 2/3] powerpc/eeh: EEH support for VFIO PCI device
Message-ID: <20140606004640.GA12581@shangw>
References: <1401950169-30206-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401950169-30206-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1401951004.3247.114.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401951004.3247.114.camel@pasglop>
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, alex.williamson@redhat.com,
 qiudayu@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2014 at 04:50:04PM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2014-06-05 at 16:36 +1000, Gavin Shan wrote:
>> +#define EEH_OPT_GET_PE_ADDR    0       /* Get PE addr  */
>> +#define EEH_OPT_GET_PE_MODE    1       /* Get PE mode  */
>
>I assume that's just some leftover from the previous patches :-)
>
>Don't respin just yet, let's see what other comments come in.
>

Yep, I'll remove them in next revision. Thanks, Ben.

Thanks,
Gavin
