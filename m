Date: Fri, 12 Oct 2001 07:32:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems building 2.4.10-ac11?  Am I missing a ppc specific patches
Message-ID: <20011012073223.O21564@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011012124823.GGKC27994.tomts14-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011012124823.GGKC27994.tomts14-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 12, 2001 at 08:50:33AM -0400, Kevin B. Hendricks wrote:

> I seem to have trouble building Alan's 2.4.10-ac11.
>
> First pc_keyb.c is missing the follwoing line:
>
> #include <linux/pm.h>

Hopefully fixed soon..

> I compared this with Ben's version of agpgart_be.c and the ac version
> seems to be missing a lot of ppc specific pieces that are in Ben's tree.

agpgart only works for us in Ben's tree.  'Normal' dri stuff should be
OK tho. (PCIgart).

[snip]
> Is there a ppc specific version of the AC tree anyplace, that I should be
> grabbing?  Or have the stability issues in the VM in the Linus tree been
> fixed?  I noticed that Linus was already at 2.4.12 and even that needed
> patches.

The diff vs linuxppc_2_4 and -ac11/-ac12 wasn't too interesting.  vs
2.4.12-ac1 is even less so (since we did a good merge into 2.4.11).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
