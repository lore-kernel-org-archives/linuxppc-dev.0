Date: Wed, 7 Mar 2001 02:35:17 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to use fp unit in kernel
Message-ID: <20010307023517.I20650@ftsoj.fsmlabs.com>
References: <3AA60D9F.FEABC67A@dspace.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AA60D9F.FEABC67A@dspace.de>; from ASchreckenberg@dspace.de on Wed, Mar 07, 2001 at 11:29:51AM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


One thing do is what we do in RTLinux (and the kernel, for that matter):

enable the fpu
save fp state

do your fp work

restore fpu state
disable fpu if it was disabled when we entered above

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
