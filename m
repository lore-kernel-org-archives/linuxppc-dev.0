Message-ID: <3C352CAB.8CE01C69@kegel.com>
Date: Thu, 03 Jan 2002 20:16:43 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	"omniorb-list@uk.research.att.com" <omniorb-list@uk.research.att.com>,
	Steven Mueller <diffusor@ugcs.caltech.edu>
Subject: omniorb 3 on linuxppc howto
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
my colleague Steve and I are trying out Corba on x86 linux
desktops and embedded Hard Hat 2.0 linux on embedded ppc405.
He's putting together a recipe for how to compile Omniorb3
for both environments and run the omniorb echo example between
them.  A first draft of the recipe is at
   http://www.ugcs.caltech.edu/~diffusor/omni-ppc405/omni-ppc405.html
Maybe it will be useful for others trying to use Corba on the ppc.
(It also contains our script for building gcc3.02.  Yes, I know 3.03
is out... we'll switch soon.)

We're having a problem, though; the servant dies with an exception
if run on the ppc.  We don't yet have a debugger on our ppc system
-- that's next -- so who knows what the issue is.  The client
works fine on the ppc, so we're at least partway there.
Suggestions cheerfully accepted :-)

- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
