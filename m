Date: Wed, 13 Feb 2002 19:53:07 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	<yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: new G4 dual 1 gig is here - how to install?
In-Reply-To: <B58DFA00-20F2-11D6-B4A8-0003938E434C@ivey.uwo.ca>
Message-ID: <Pine.BSF.4.44.0202131947110.42574-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Feb 2002, Kevin B. Hendricks wrote:

> 2.  The bad news is that my ATI 7500 with my flat panel display simply
> goes black so I can't tell exactly what is detected or not.


You will need to check if the OpenFirmware pll probing code I use in
radeonfb works on 7500.  Look in the device-tree node and see what the
reference clock is.  If you look in radeon_get_pllinfo() you can see the
OF probe code there.  IIRC on x86 7500 boards, the xclk is ~ 22000, the
ref div is 12 and reference clock is 2700 i belive.  The 7500 is supported
on x86 btw.

If you can log in and get a bootlog that would be helpful.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
