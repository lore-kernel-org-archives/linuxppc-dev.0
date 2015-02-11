Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 535111A0902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:58:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 20:58:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6E70C2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:58:41 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1BAwX5X41746616
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:58:41 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1BAw768011708
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 21:58:08 +1100
Message-ID: <54DB35A7.8030609@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2015 16:27:43 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] opal: Add message notifier unregister function
References: <20150211062616.3279.71632.stgit@localhost.localdomain>
 <20150211062712.3279.93469.stgit@localhost.localdomain>
In-Reply-To: <20150211062712.3279.93469.stgit@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2015 11:57 AM, Neelesh Gupta wrote:
> Provide an unregister interface for the opal message notifiers
> to be called when not needed like during driver unload/remove.

Why only for unload/remove, you can also use it in cases where you need
to abort because of any other error soon after successful registration
for an OPAL message. 
