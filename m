Message-ID: <3EA82FBF.6080001@embeddededge.com>
Date: Thu, 24 Apr 2003 14:41:03 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Kent Borg <kentborg@borg.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: boot/simple in ROM?
References: <20030424123313.A8490@borg.org> <3EA81B3F.9080709@embeddededge.com> <20030424133222.B8490@borg.org> <3EA823A1.7030905@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark A. Greer wrote:

> You're a little sparse on info here but try lopping off the first 64KB
> of your zImage (or jump 0x10000 into the zImage that you have).

Oh yeah...good point.  It's just a reflex for me to check this, so
I seldom think of it anymore.  I think some board builds automatically
chop this in the makefile with a 'dd' command (or, they used to) :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
