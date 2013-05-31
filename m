Return-Path: <hughd@google.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B667C2C02EA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Jun 2013 00:45:10 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id rp8so2299513pbb.22
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 07:45:06 -0700 (PDT)
Date: Fri, 31 May 2013 07:45:08 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
In-Reply-To: <1369978262.3928.111.camel@pasglop>
Message-ID: <alpine.LNX.2.00.1305310742001.13527@eggly.anvils>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
 <1369897236.3928.93.camel@pasglop> <87vc60na89.fsf@linux.vnet.ibm.com>
 <1369902786.3928.94.camel@pasglop>
 <alpine.LNX.2.00.1305300643150.10009@eggly.anvils>
 <alpine.LNX.2.00.1305302201200.12852@eggly.anvils>
 <1369978262.3928.111.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 31 May 2013, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-30 at 22:05 -0700, Hugh Dickins wrote:
> > > Sure, it's now under way.  If all goes well, I'll give you a
> > > progress report in about 15 hours time; but given the variance in
> > > how long it took to hit, I won't feel fully confident until this
> > > time tomorrow, when I'll update you again.
> > 
> > Still running fine.  I'll leave it running a few more hours to make
> > sure, and then try switching to the patch Aneesh sent afterwards -
> > or say if you'd prefer me to switch over to that one immediately.
> 
> The patch you are running on is what I'll send to Linus for 3.10 (+/-
> cosmetics). Aneesh second patch is a much larger rework which will be
> needed for THP but that will wait for 3.11. I'm happy for you to test it
> but I first want to make sure it's solid with the 3.10 fix :-)

That makes sense.
The first patch ran fine without incident for 25 hours, I say it's good.
I've now stopped that run and started another with the second patch in.

Hugh
