Return-Path: <rth7680@gmail.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 10C951A0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 01:02:45 +1000 (EST)
Received: by mail-ie0-f178.google.com with SMTP id tp5so4468214ieb.23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 08:02:41 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
Message-ID: <53C5428E.5050400@twiddle.net>
Date: Tue, 15 Jul 2014 08:02:38 -0700
From: Richard Henderson <rth@twiddle.net>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Oleg Nesterov <oleg@redhat.com>
Subject: Re: bit fields && data tearing
References: <20140712181328.GA8738@redhat.com>	
 <20140712205130.GA16437@redhat.com> <1405208082.20996.54.camel@pasglop>	
 <53C2865B.5040200@hurleysoftware.com> <1405290324.20996.71.camel@pasglop>
 <53C53288.0@hurleysoftware.com>
In-Reply-To: <53C53288.0@hurleysoftware.com>
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Dan <opendtv@yahoo.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Miroslav Franc <mfranc@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2014 06:54 AM, Peter Hurley wrote:
> 
> Jonathan Corbet wrote a LWN article about this back in 2012:
> http://lwn.net/Articles/478657/
> 
> I guess it's fixed in gcc 4.8, but too bad there's not a workaround for
> earlier compilers (akin to -fstrict_volatile_bitfields without requiring
> the volatile keyword)

>From the gcc pr, it looks like the patch was backported to 4.7.
But we didn't fix it in versions earlier than that.


r~
