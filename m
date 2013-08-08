Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B58452C007A
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 14:10:51 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Aug 2013 01:05:38 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6E5612CE804D
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 14:10:49 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r783swhG7668162
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 13:54:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r784AmSJ014463
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 14:10:48 +1000
Message-ID: <52031A18.90804@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 09:40:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/9] powerpc: Split the common exception prolog logic
 into two section.
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093806.5389.41596.stgit@mars.in.ibm.com>
In-Reply-To: <20130807093806.5389.41596.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2013 03:08 PM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This patch splits the common exception prolog logic into two parts to
> facilitate reuse of existing code in the next patch. The second part will
> be reused in the machine check exception routine in the next patch.
> 

Please avoid describing the functionality as a requirement for upcoming
sibling patches. Justification to split the code should be generic functional
or code organizational requirement. We should avoid the word "next patch" in
the commit message, as it would be confusing when you read it later point of
time. The commit message should be self sufficient pertaining to the exact
code change set in consideration.
