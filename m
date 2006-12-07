Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id CAD7367C4A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 14:25:40 +1100 (EST)
Date: Wed, 6 Dec 2006 21:25:23 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] add rtas_service_present() helper
Message-ID: <20061207032523.GG18846@localdomain>
References: <11654526463043-git-send-email-ntl@pobox.com>
	<11654526511379-git-send-email-ntl@pobox.com>
	<11654526533213-git-send-email-ntl@pobox.com>
	<1165459893.14780.0.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1165459893.14780.0.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2006-12-06 at 18:50 -0600, Nathan Lynch wrote:
> > To test for the existence of an RTAS function, we typically do:
> > 
> >    foo_token = rtas_token("foo");
> >    if (foo_token == RTAS_UNKNOWN_SERVICE)
> >       return;
> > 
> > Add a rtas_service_present method, which provides a more conventional
> > boolean interface for testing the existence of an RTAS method.
> 
> 
> I like it a lot ..
> 
> But should it be called rtas_token_present() ? :D

I considered that, but thought my name was a little more descriptive
-- a token is merely an integer value, but we're really interested in
whether the service named is available.

I don't really care that much either way, though :)
