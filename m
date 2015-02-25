Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC4FD1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 08:54:01 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 25 Feb 2015 16:53:59 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4B5F838C8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 16:53:57 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1PLrtK224445010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 21:53:55 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1PLrtXU032687
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2015 16:53:55 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Cedric Le Goater <clg@fr.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/powernv: check OPAL_REGISTER_DUMP_REGION calls
 exist
In-Reply-To: <54EE3E93.6070001@fr.ibm.com>
References: <1424886188-32068-1-git-send-email-clg@fr.ibm.com>
 <m3vbipeloe.fsf@oc8180480414.ibm.com> <54EE3E93.6070001@fr.ibm.com>
Date: Thu, 26 Feb 2015 08:53:52 +1100
Message-ID: <m3pp8xejyn.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cedric Le Goater <clg@fr.ibm.com> writes:
> On 02/25/2015 10:16 PM, Stewart Smith wrote:
>> C=C3=A9dric Le Goater <clg@fr.ibm.com> writes:
>>> On Open Power systems, such call fails in OPAL :=20
>>>
>>>    OPAL: Called with bad token 101 !
>>>
>>> The check on the OPAL_UNREGISTER_DUMP_REGION call is added for=20
>>> symmetry. I did not see any errors for it.
>>=20
>> I've already put in a patch to squash this:
>> Message-Id:
>> <1423718729-17992-2-git-send-email-stewart@linux.vnet.ibm.com>
>>=20
>> Just waiting on mpe to merge :)
>
> ok fine, I missed it :)=20
>
> I am also tempted to fix OPAL_READ_TPO but the proper way to do this=20
> would be to move the lowlevel OPAL code from drivers/rtc/rtc-opal.c to=20
> a new file under arch/powerpc/platforms/powernv/. How does that sound ?=20

shouldn't we be detecting things from DT and acting on it? From a quick
glance perhaps we're not quite doing the checks in all the right places?
