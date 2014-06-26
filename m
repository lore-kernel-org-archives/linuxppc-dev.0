Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BD951A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 09:53:13 +1000 (EST)
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3535B1400D2
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2014 09:53:11 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 26 Jun 2014 19:53:09 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 182FCC90026
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 19:53:00 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5QNr6p45505528
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 23:53:06 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5QNr5MG013714
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2014 19:53:06 -0400
Date: Thu, 26 Jun 2014 16:52:30 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: crash with 3.16.0-rc2
Message-ID: <20140626235230.GA29080@us.ibm.com>
References: <20140626061015.GA13181@us.ibm.com> <53ABC37C.6050101@fr.ibm.com>
 <1403770940.18572.7.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403770940.18572.7.camel@concordia>
Cc: linuxppc-dev@ozlabs.org, Cedric Le Goater <clg@fr.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
| > A patch from Michael Ellerman was just merged : 
| > 
| > 	powerpc/powernv: Remove OPAL v1 takeover
| > 
| > I think it fixes the problem you are seeing.
| 
| Yes it should.

It does fix the problem.
