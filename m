Message-ID: <406455E9.90809@embeddededge.com>
Date: Fri, 26 Mar 2004 11:10:17 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jos Beck <jos_beck@euronet.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Preferred Phy for MPC8260
References: <406448EC.5030009@euronet.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jos Beck wrote:

> Would anyone of you know a preferred 10/100baseT phy for the MPC8260?
> Or specific brands/types to avoid?
> Or does it really not matter what we use?

It depends completely on your system requirements.  There are many different
PHYs supported in the software right now, and it is relatively easy to
add new ones.  Some of the features you may want to consider are whether
you want single or multiple PHYs in one package, and take a look at the
detail of how they may interrupt the processor on link changes and if
that is suitable for your product.  For software compatibility, it's
more important how the PHY is connected to the pins of the processor
(due to its flexibility) than which one is used.

In typical fashion, when the LXT parts changed hands there were some
subtle differences from the original that has made them a PITA, so they
aren't high on my list, but something still makes them attractive to use :-)
My preference is AMD networking products.

Good Luck. :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
