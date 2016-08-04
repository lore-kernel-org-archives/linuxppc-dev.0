Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4bcB0LXLzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 13:52:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 3s4bc954B7z9stY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 13:52:25 +1000 (AEST)
Date: Thu, 4 Aug 2016 13:52:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: DMARC (and DKIM) problems
Message-ID: <20160804135225.6a518d21@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

For some time we have been coping with DMARC by rewriting the sender address
for any email sent from a site with a restrictive DMARC policy.  This was
because the DKIM verification would fail for such an email once it had been
processed by the mailing list software and so sites (like Yahoo) who
implemented DMARC would bounce such emails.

It turns out that by just not adding the footer to each email, we no
longer break the DKIM signatures.  So, I have turned off the footer and
will leave it that way unless someone objects.

This means that I have also turned off sender address rewriting.

-- 
Cheers,
Stephen Rothwell
