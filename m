Message-ID: <39A66098.D5527A69@student.ethz.ch>
Date: Fri, 25 Aug 2000 14:03:37 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Malcolm Purvis <malcolmpurvis@optushome.com.au>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Emulating button 3 on 2 button ADB mice.
References: <14758.21537.701471.542545@co3018576-a.rivrw1.nsw.optushome.com.au>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Malcolm Purvis wrote:

> I welcome suggestions as to where to put the fix so I can submit it to the
> right people.

You can send the XFree86 patch to fixes@XFree86.Org . Also state that you're
not sure if it belongs there or in the kernel.

Anyway, I think if you make this an option ("ButtonOrder" ?) for the Pointer
Input Device Section, I think chances are high it will be accepted.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
