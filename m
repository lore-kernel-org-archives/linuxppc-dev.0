From: "Georg Klug" <gklug@giga-stream.de>
To: <linas@austin.ibm.com>,
	"Thomas Sch?fer" <tschaefer@giga-stream.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: AW: Boot problems with MPC8280 PowerQUICC
Date: Fri, 7 Nov 2003 18:47:17 +0100
MIME-Version: 1.0
Message-ID: <FFECLICFNBJAHONLGAKMAEELCOAA.gklug@giga-stream.de>
In-Reply-To: <20031107105648.A34844@forte.austin.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Linas,

> On Mon, Oct 13, 2003 at 07:35:47PM +0200, Thomas Sch?fer wrote:
> > INIT: Id "con" respawning too fast: disabled for 5 minutes
>
> FYI, this has been seen on and off on ppc64 too ... I don't know if it
> was ever fixed, or just worked around. I vaguely remember it had to do
> with a misconfigured/non-existant serial port.

Thanks for that help. In our the reason was that the processor MPC8280 was
unknown to the kernel. Adding it to the cputable helped a lot!

Georg

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
