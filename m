Message-Id: <200010121625.LAA22009@lists.linuxppc.org>
From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
Reply-To: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Cc: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>, Josh Huber
	 <huber@mclx.com>,
        Linux/PowerPC Devel List
	 <linuxppc-dev@lists.linuxppc.org>
Date: Thu, 12 Oct 2000 12:25:30 -0400
Content-Type: text/plain;
	charset=us-ascii
Subject: Re: dual head r128
Mime-Version: 1.0 (Apple Message framework v337)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> The current test only checks if a rom is present not if a bios or OF segment
> is there, it needs to be fixed to check that its really reading from a
> bios rom and not from something else (OF).

So that is what is happening.  Perhaps we could simply add a check to make sure the REF clock value read from whatever looks like a bios actually is one of the 3 allowed values (2950, ...) and if so, assume the bios is present and if not default to something else.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
