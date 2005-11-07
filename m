Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id A96BA686B4
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 01:59:05 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 7 Nov 2005 16:58:58 +0200
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<20051107084431.GA15180@logos.cnet>
In-Reply-To: <20051107084431.GA15180@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511071558.58970.david.jander@protonic.nl>
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 07 November 2005 09:44, Marcelo Tosatti wrote:
> Seems the bug is exposed by the change which avoids flushing the
> TLB when not necessary (in case the pte has not changed), introduced
> recently:
>[...]

Brilliant!
I just checked, and now it boots again.
Btw, it did boot before this patch, but taking about 2 or 3 hours to get 
halfway through the init scripts ;-)

Thanks for the good work!

-- 
David Jander
