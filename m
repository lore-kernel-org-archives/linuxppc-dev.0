Return-Path: <benh@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09BEC2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 15:31:11 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Fri, 31 May 2013 15:20:26 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 849A22CE8023
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 15:31:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4V5Gav827263198
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 15:16:36 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4V5V2j7024167
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 15:31:03 +1000
Message-ID: <1369978262.3928.111.camel@pasglop>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Hugh Dickins <hughd@google.com>
Date: Fri, 31 May 2013 15:31:02 +1000
In-Reply-To: <alpine.LNX.2.00.1305302201200.12852@eggly.anvils>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
 <1369897236.3928.93.camel@pasglop> <87vc60na89.fsf@linux.vnet.ibm.com>
 <1369902786.3928.94.camel@pasglop>
 <alpine.LNX.2.00.1305300643150.10009@eggly.anvils>
 <alpine.LNX.2.00.1305302201200.12852@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 22:05 -0700, Hugh Dickins wrote:
> > Sure, it's now under way.  If all goes well, I'll give you a
> > progress report in about 15 hours time; but given the variance in
> > how long it took to hit, I won't feel fully confident until this
> > time tomorrow, when I'll update you again.
> 
> Still running fine.  I'll leave it running a few more hours to make
> sure, and then try switching to the patch Aneesh sent afterwards -
> or say if you'd prefer me to switch over to that one immediately.

The patch you are running on is what I'll send to Linus for 3.10 (+/-
cosmetics). Aneesh second patch is a much larger rework which will be
needed for THP but that will wait for 3.11. I'm happy for you to test it
but I first want to make sure it's solid with the 3.10 fix :-)

Thanks !

Cheers,
Ben.
