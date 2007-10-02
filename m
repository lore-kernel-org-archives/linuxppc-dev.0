Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.230])
	by ozlabs.org (Postfix) with ESMTP id 7EED4DDF2A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 02:23:23 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so2914675nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 09:23:21 -0700 (PDT)
Message-ID: <fa686aa40710020923n7a92219ds7a5c920990bcd25e@mail.gmail.com>
Date: Tue, 2 Oct 2007 10:23:20 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
In-Reply-To: <47026D5C.4050308@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk> <47026D5C.4050308@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Scott Wood <scottwood@freescale.com> wrote:
> It would be nice, though, to merge platform and of_platform to some
> extent, so that things which don't need to check "special" device tree
> properties wouldn't have to make any changes other than maybe adding an
> extra match table entry.

yes, that would be really nice.

On that note, is it possible to modify the device tree (and of_device
registrations) at run time?  The one feature I do really like about
using the platform bus is that you can register/unregister devices at
run time.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
