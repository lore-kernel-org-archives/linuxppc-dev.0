Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C17C21A0AC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 15:30:39 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 2 Oct 2014 23:30:36 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 002CC3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 23:30:33 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s935UXHl50069524
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 07:30:33 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s935UXld011324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Oct 2014 23:30:33 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/4] powerpc/powernv: Sync header with firmware
In-Reply-To: <20140925042747.8E2AE14016A@ozlabs.org>
References: <20140925042747.8E2AE14016A@ozlabs.org>
Date: Fri, 03 Oct 2014 15:30:31 +1000
Message-ID: <m3a95dhg94.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: qiudayu@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
>> +	OpalEjtIoaDmaWriteMemTarget	= 19,
>> +};
>
> I realise these come from the skiboot source, but they're just too ugly.
>
> Please use kernel style naming, like most of the rest of the file, eg:
>
> 	OPAL_ERR_INJECT_IOA_BUS_ERR

You know what, I think I'd feel better if we changed skiboot source to
be like this too. Many of the other enums in skiboot are kernel style
and not camel. So, I'm going to go do that, then kernel and firmware can
match.
