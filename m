Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB9BF1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 08:16:57 +1100 (AEDT)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 25 Feb 2015 14:16:55 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 103013E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 14:16:53 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t1PLGqDT29884548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 14:16:52 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1PLGqcF001489
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 14:16:52 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@fr.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/powernv: check OPAL_REGISTER_DUMP_REGION calls
 exist
In-Reply-To: <1424886188-32068-1-git-send-email-clg@fr.ibm.com>
References: <1424886188-32068-1-git-send-email-clg@fr.ibm.com>
Date: Thu, 26 Feb 2015 08:16:49 +1100
Message-ID: <m3vbipeloe.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C=C3=A9dric Le Goater <clg@fr.ibm.com> writes:
> On Open Power systems, such call fails in OPAL :=20
>
>    OPAL: Called with bad token 101 !
>
> The check on the OPAL_UNREGISTER_DUMP_REGION call is added for=20
> symmetry. I did not see any errors for it.

I've already put in a patch to squash this:
Message-Id:
<1423718729-17992-2-git-send-email-stewart@linux.vnet.ibm.com>

Just waiting on mpe to merge :)
