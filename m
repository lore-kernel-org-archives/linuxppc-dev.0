From: linas@austin.ibm.com
Date: Fri, 7 Nov 2003 10:56:48 -0600
To: Thomas Sch?fer <tschaefer@giga-stream.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Boot problems with MPC8280 PowerQUICC
Message-ID: <20031107105648.A34844@forte.austin.ibm.com>
References: <FIEJJAKAABLMHFKFECNJOEKIGPAA.tschaefer@giga-stream.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FIEJJAKAABLMHFKFECNJOEKIGPAA.tschaefer@giga-stream.de>; from tschaefer@giga-stream.de on Mon, Oct 13, 2003 at 07:35:47PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Oct 13, 2003 at 07:35:47PM +0200, Thomas Sch?fer wrote:
> INIT: Id "con" respawning too fast: disabled for 5 minutes

FYI, this has been seen on and off on ppc64 too ... I don't know
if it was ever fixed, or just worked around.  I vaguely remember
it had to do with a misconfigured/non-existant serial port.

--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
