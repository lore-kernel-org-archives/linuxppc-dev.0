Message-ID: <3B38C289.7050008@mvista.com>
Date: Tue, 26 Jun 2001 10:12:41 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Segmentation fault while dynamic linking
References: <5.0.2.1.0.20010626172652.00a69210@pop.gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Habermann wrote:

> My configuration: Kernel 2.4.4, glibc 2.2.2, bash 2.05, FADS, MPC855T

who's toolchain are you using?  glibc 2.2.x has a cacheline size bug for
the smaller cacheline ppc processors.  Our toolchain has a fix for it.
grab our HHL 2.0 Journeyman edition and give it a try.
http://www.mvista.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
