Message-ID: <404665B3.20409@mvista.com>
Date: Wed, 03 Mar 2004 16:09:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Neil Wilson <NWilson@Airspan.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Stuart Yoder <stuart.yoder@conformative.com>
Subject: Re: Porting Linux into IBM Spruce
References: <3506EDCDEC47904CBE6FD2E1DEEA8984020CF952@fs5.airspan.com> <40460CEF.4050900@mvista.com>
In-Reply-To: <40460CEF.4050900@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark A. Greer wrote:

>
> Neil Wilson wrote:
>
>> What about the IBM 2*750FX + MV64360 dev board ?, would this be a port
>> of Spruce + a different PCI bridge, I cannot seem to find an exact match
>> in the platforms but there again maybe I am looking in the wrong
>> tree/directory, thanks.
>>
> That's an Argan board and, as you note, its very different from a spruce
> so it will get its own port.  That port is being worked on but isn't
> ready yet.  If you can hold tight for a bit I will try to get you an
> early version.

Okay, here is the problem.  We have a port that works (using 1 processor
only) but its based on the 64360 code that was put into the -galileo
tree.  AFAIK, that 64360 code it not acceptable for the _2_4_devel or
the -2.4 tree so we can't put it in those trees.  There is also a file
with a non-GPL license so that has to be rewritten before anything is
released.

When that's done, I am told there will be a preview kit for it available
from mvista.com.  Preview kits are freely available but you have to
register (free).  Right now, that preview kit is expected to be
available in ~4 weeks but no guarantees.

That's the best I can do so if that's not good enough, you'll have to do
it yourself or maybe someone else has a working src tree they are
willing to share.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
