Date: Wed, 29 Oct 2003 14:19:37 -0600
Subject: Re: Video mirroring with radeon mobility 9600
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Ken Offer <koffer@arlut.utexas.edu>
In-Reply-To: <1067386942.3332.49.camel@gaston>
Message-Id: <37C1811E-0A4D-11D8-A560-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday, October 28, 2003, at 06:22  PM, Benjamin Herrenschmidt
wrote:

> The whole mirroring thing must be re-implemented differently. It's
> on my todolist, though not done yet
>
> Ben.

Hi Ben,

I'd like to try to get mirroring working.  Unfortunately, I don't have
technical documentation on the Radeon 9600 Mobility chipset.  Is there
a document somewhere on-line I can consult?

The "ATI Radeon display support" page when I do a "make menuconfig" in
the 2.6 kernel source refers to this page:

	http://www.ati.com/na/pages/products/pc/radeon32/index.html

Unfortunately its a broken link.

I've been hunting around on www.ati.com.  I can find tons of product
descriptions, product announcements, application demo code and
pre-built drivers.  Unfortunately that doesn't help when you need to
know what bit in what hardware register to twiddle. :)

+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
