Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (vs166246.vserver.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19BFFDDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 02:36:39 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] powerpc: Do not fail build if mkimage is not available
Date: Wed, 26 Dec 2007 16:35:42 +0100
References: <200712261453.41849.mb@bu3sch.de> <200712261610.28489.mb@bu3sch.de>
	<je8x3h31y2.fsf@sykes.suse.de>
In-Reply-To: <je8x3h31y2.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712261635.43188.mb@bu3sch.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, paulus@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 December 2007 16:33:57 Andreas Schwab wrote:
> Michael Buesch <mb@bu3sch.de> writes:
> 
> > On Wednesday 26 December 2007 15:47:05 Andreas Schwab wrote:
> >> Michael Buesch <mb@bu3sch.de> writes:
> >> 
> >> > +    if ! [ -x mkimage ]; then
> >> 
> >> What is this supposed to test?
> >
> > from man test:
> 
> You didn't answer my question.

I'm not sure how I can make the manual text any clearer

       -x FILE
              FILE exists and execute (or search) permission is granted

It tests if the program exists and is executable.
Could you please be more specific about what you don't understand?
That would help a lot not wasting my time.

-- 
Greetings Michael.
