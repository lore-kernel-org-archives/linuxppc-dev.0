Date: Thu, 13 Feb 2003 15:52:47 -0700 (MST)
From: daRonin <daronin@digimerc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: DVI External Monitor on TiBook IV
In-Reply-To: <1044898053.10697.27.camel@thor>
Message-ID: <Pine.LNX.4.53.0302131535570.1429@daronin.digimerc.com>
References: <Pine.LNX.4.44.0302101721560.23854-100000@zirkon.biophys.uni-duesseldorf.de>
 <1044898053.10697.27.camel@thor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am running with external Cinema 23" display on my TiBook IV (Radeon
Mobility 9000).

The combination works great with earily 2.4.20 kernels, however with
2.4.20-ben5 my LCD stays on and goes white.

I managed to determine that LCD is not turned on by radeonfb, it turns own
earlier in the boot process. So even with video=ofonly the LCD stays on.

My knowledge of kernel workings is not sufficent to determine where
exactely the problem occurs. I would appreciate any lead into the right
direction...

Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
