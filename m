Message-ID: <20040302173411.50777.qmail@web21113.mail.yahoo.com>
Date: Tue, 2 Mar 2004 09:34:11 -0800 (PST)
From: Lou Rickard <lou_rickard@yahoo.com>
Subject: RE: ml300 system init very slow
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <8039970AF146314597457D3B51A68B388F36B2@cossmgmbx02.email.corp.tld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


And as the kernel boots, it loads an improved serial
module stored on the root filesystem, which works
fine?  Would that explain why it works fine with
module support turned on, but doesn't work well with
module support turned off (and hence stuck using the
serial module that is built into the kernel)?

~lr

--- "VanBaren, Gerald (AGRE)"
<Gerald.VanBaren@smiths-aerospace.com> wrote:
>
> Just in case nobody answered yet (I didn't see an
> answer), the problem 99.9999% certainty is that your
> serial interrupts are not interrupting so the kernel
> is polling for serial I/O.  This is a fallback
> operation with REALLY LONG timeouts.  The symptoms
> are REALLY SLOW console interaction == your
> symptoms.  Your follow-up message indicates the
> problem is in your serial driver module.
>
> gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
