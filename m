Message-ID: <393B1125.B3F1C285@charter.net>
Date: Sun, 04 Jun 2000 21:32:05 -0500
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Daniel Wu <Daniel.Wu@alcatel.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel crashes at InstructionTLBMiss
References: <00Jun4.144038est.115228@border.alcanet.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daniel Wu wrote:
...
> I then ran the same code using a BDM debugger and it is showing that the code
> is crashing at InstructionTLBMiss:

Daniel,
your problem sounds suspiciously like a problem I was having with
the mpc8bug debugger.  Issuing a 'rms der 0' command before the
'go ...' worked well for me.  Why don't you give that a try?
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
