Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 566FD1400D4
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:51:20 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 May 2014 15:51:20 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 030632BB0040
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:51:16 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E5p0n410682646
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:51:00 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E5pFhr005448
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:51:15 +1000
Message-ID: <537303E4.4050903@linux.vnet.ibm.com>
Date: Wed, 14 May 2014 11:19:24 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <5372547D.8040209@redhat.com>
In-Reply-To: <5372547D.8040209@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, avagin@openvz.org, Roland McGrath <roland@hack.frob.com>,
 linux-kernel@vger.kernel.org, oleg@redhat.com, michael@ellerman.id.au,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2014 10:51 PM, Pedro Alves wrote:
> I wonder whether people are getting Roland's address from?
> 
> It's frequent that ptrace related patches end up CCed to
> roland@redhat.com, but, he's not been at Red Hat for a few years
> now.  Roland, do you still want to be CCed on ptrace-related
> issues?  If so, there's probably a script somewhere in the
> kernel that needs updating.  If not, well, it'd be good
> if it were updated anyway.  :-)
> 
> It's a little annoying, as Red Hat's servers outright reject
> email sent from a @redhat.com address if one tries to send
> an email that includes a CC/FROM to a user that no longer
> exists in the @redhat.com domain.

Got the email address from some of the previous ptrace related
commits.
