Return-Path: <victork@il.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AB4612C008E
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 03:31:08 +1100 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <victork@il.ibm.com>;
 Fri, 1 Nov 2013 16:31:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C9FCC2190056
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Nov 2013 16:31:03 +0000 (GMT)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA1GUpqD55640158
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 16:30:51 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rA1GV2T3018062
 for <linuxppc-dev@ozlabs.org>; Fri, 1 Nov 2013 10:31:03 -0600
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B73D4@saturn3.aculab.com>
References: <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <OFDF23985D.1D949148-ON42257C15.002DEB25-42257C15.0036DF93@il.ibm.com>
 <20131031152543.GC4067@linux.vnet.ibm.com>
 <OF3CB471BA.BACC7843-ON42257C16.0055EF23-42257C16.0058875B@il.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B73D4@saturn3.aculab.com>
Subject: RE: perf events ring buffer memory barrier on powerpc
To: "David Laight" <David.Laight@aculab.com>
Message-ID: <OF57D6EF77.CD2E45CE-ON42257C16.005AA6D8-42257C16.005AB961@il.ibm.com>
From: Victor Kaplansky <VICTORK@il.ibm.com>
Date: Fri, 1 Nov 2013 18:30:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"David Laight" <David.Laight@aculab.com> wrote on 11/01/2013 06:25:29 PM:
> gcc will do unexpected memory accesses for bit fields that are
> adjacent to volatile data.
> In particular it may generate 64bit sized (and aligned) RMW cycles
> when accessing bit fields.
> And yes, this has caused real problems.

Thanks, I am aware about this bug/feature in gcc.
-- Victor
