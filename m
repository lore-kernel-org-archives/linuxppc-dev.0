Date: Thu, 10 Feb 2000 21:16:25 -0500
From: Clint Hepner <chepner@cs.dartmouth.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: TCP stalls and VJ compression
Message-ID: <20000210211623.B896@cs.dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I don't know if this had been resolved yet or not. This is the experience
I've had this evening.

I've been having problems with stalled downloads, mainly in Netscape,
for several weeks now. Also, I've been unable to rsync from linuxcare;
rsync would stop once I saw the "receiving file list..." message.
I was searching through the archives tonight, and found the recommendation to
disable Van Jacobsen header compression on the PPP link. I wasn't sure this
would work, though, since I'm not actually running PPP on my machine; I
connect over Ethernet through a Mac running IPNetRouter for a PPP dialup.
However, disabling header compressoin solved both of my problems: Netscape
downloads without stalling, and I can rsync from linuxcare again.

I'm running a 2.2.15-pre6 kernel, which I complied myself from source
downloaded earlier today. Again, I don't know if this is still an open
problem, or if I'm just missing a patch that's already been developed.
If anyone is working on this, I'd be happy to give a more detailed
account of my setup and the situation before and after my fix.

Clint Hepner
chepner@cs.dartmouth.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
