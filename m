Date: Wed, 26 Apr 2000 13:23:18 +0200
From: "David N. Welton" <davidw@linuxcare.com>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Netbooting cross-compiled imac kernel
Message-ID: <20000426132318.E8268@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So, I had a spare moment, and managed to get a kernel cross-compiled
for an imac I have around here.  I netboot it with yaboot 0.6, which
seems to work ok, but then it dies very early on, after "calling
RTAS".

I am using the standard pmac_config, gcc and binutils checked out of
CVS, and cross compiling from i386.

Ideas?
--
David N. Welton, Responsabile Progetti Open Source, Linuxcare Italia spa
tel +39.049.8043411 fax +39.049.8043412 cel +39.348.2879508
davidw@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
