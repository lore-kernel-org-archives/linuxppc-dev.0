Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B7BB1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 14:53:02 +1000 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 22:53:00 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id B310C19D8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 22:52:48 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5Q4pYkR8847834
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 06:51:34 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5Q4qvmL017091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 22:52:57 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
In-Reply-To: <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Thu, 26 Jun 2014 14:52:53 +1000
Message-ID: <m361jouva2.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, agraf@suse.de,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
> +static struct kobj_attribute errinjct_attr =
> +	__ATTR(errinjct, 0600, NULL, errinjct_store);

May also be good to have a read method that either lists current
injected errors? I guess it depends on if they're one time errors or
persistent errors too.
