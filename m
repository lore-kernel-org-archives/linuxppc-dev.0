Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by ozlabs.org (Postfix) with ESMTP id 50F4CDDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 12:41:21 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so312368rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 19:41:20 -0700 (PDT)
Message-ID: <fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>
Date: Wed, 24 Oct 2007 20:41:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Brownell" <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
In-Reply-To: <200710241850.05467.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071024163412.GA17785@ru.mvista.com>
	<471FC191.6020704@genesi-usa.com>
	<200710241850.05467.david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/24/07, David Brownell <david-b@pacbell.net> wrote:
> On Wednesday 24 October 2007, Matt Sealey wrote:
> > Can we just make sure real quickly that the changing of compatibles
> > doesn't break existing, not-easily-flashable firmwares?
>
> Yeah, I'm not keen on such breakage either...

Add my voice to the chorus.  It's okay to change the binding, but make
sure the old binding is still supported.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
