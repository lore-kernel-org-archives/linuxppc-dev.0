Return-Path: <hughd@google.com>
Received: from mail-pd0-f182.google.com (mail-pd0-f182.google.com
 [209.85.192.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 149B32C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 23:48:49 +1000 (EST)
Received: by mail-pd0-f182.google.com with SMTP id g10so378727pdj.41
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 06:48:47 -0700 (PDT)
Date: Thu, 30 May 2013 06:48:48 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: 3.10-rc ppc64 corrupts usermem when swapping
In-Reply-To: <1369902786.3928.94.camel@pasglop>
Message-ID: <alpine.LNX.2.00.1305300643150.10009@eggly.anvils>
References: <alpine.LNX.2.00.1305292148550.9560@eggly.anvils>
 <1369897236.3928.93.camel@pasglop> <87vc60na89.fsf@linux.vnet.ibm.com>
 <1369902786.3928.94.camel@pasglop>
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

On Thu, 30 May 2013, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-30 at 13:57 +0530, Aneesh Kumar K.V wrote:
> > +               /* FIXME!!, will fail with when we enable hugepage
> > support */
> 
> Just fix that to say "Transparent huge pages" as normal huge pages
> should work fine unless I'm missing something.
> 
> Hugh, any chance you can give that a spin ? 

Sure, it's now under way.  If all goes well, I'll give you a
progress report in about 15 hours time; but given the variance in
how long it took to hit, I won't feel fully confident until this
time tomorrow, when I'll update you again.

Thank you both for the great response!

Hugh
