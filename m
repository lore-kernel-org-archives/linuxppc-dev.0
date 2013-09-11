Return-Path: <ananth@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A175A2C01EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 14:37:13 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 11 Sep 2013 05:37:10 +0100
Date: Wed, 11 Sep 2013 10:07:33 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Tom Musta <tmusta@us.ibm.com>
Subject: Re: [PATCH] powerpc: OE=1 Form Instructions Not Decoded Correctly
Message-ID: <20130911043733.GA20006@in.ibm.com>
References: <CAJ-hshaxuJBMCFquT7J50rjuDYWer_0i1=2QmnOKGAxx4n=FUw@mail.gmail.com>
 <20130908223559.GA495@iris.ozlabs.ibm.com>
 <1378721499.11525.5.camel@pasglop>
 <OF5204CF2E.B2F7FFF8-ON86257BE1.0044FF5E-86257BE1.0046077F@us.ibm.com>
 <OF8A394047.DEDB25DC-ON86257BE1.0062D6C5-86257BE1.006FC8B8@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF8A394047.DEDB25DC-ON86257BE1.0062D6C5-86257BE1.006FC8B8@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Linuxppc-dev <linuxppc-dev-bounces+tmusta=us.ibm.com@lists.ozlabs.org>,
 Tom Musta <tommusta@gmail.com>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 09, 2013 at 03:20:58PM -0500, Tom Musta wrote:
> > > Isn't that code occasionally used with uprobes too nowadays  ?
> >
> > Yes. I believe so.
> 
> I'm going to back-pedal a little.  I reread code and can connect
> single step code to kprobes but not necessarily to uprobes.  So
> I am not sure that this code is used with uprobes.

Yes, emulate_step() is used for uprobes too.

Ananth
