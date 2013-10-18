Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF6422C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 15:49:19 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 18 Oct 2013 14:49:05 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EDD792CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 15:49:03 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9I4mF9h64487480
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 15:48:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9I4iMe5002427
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 15:44:22 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH -V2 06/14] kvm: powerpc: booke: Convert BOOKE to use
 kvmppc_ops callbacks
In-Reply-To: <01BC643C-0AA9-47E8-A7E9-7A84AB280298@suse.de>
References: <1381164482-31001-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1381164482-31001-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <01BC643C-0AA9-47E8-A7E9-7A84AB280298@suse.de>
Date: Fri, 18 Oct 2013 10:14:17 +0530
Message-ID: <87eh7jqjby.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 07.10.2013, at 18:47, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> Make required changes to get BOOKE configs to build with
>> the introduction of kvmppc_ops callback
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> This can not be a separate commit, as you're breaking bisectability for booke this way.
>

The only reason I split that into two was to make review easy. But yes
when merging to your tree we should fold.

> I've squashed this in with the previous commit.
>

Ok. 

-aneesh
