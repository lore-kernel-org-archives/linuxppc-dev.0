Message-Id: <v04003a01b629191ff4ae@[24.70.162.12]>
In-Reply-To: <p04330100b629125ff911@[192.168.0.1]>
References: <v04003a00b628feabbda6@[24.70.162.12]>
 <v04003a00b628feabbda6@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 3 Nov 2000 20:01:55 -0600
To: Stefan Jeglinski <jeglin@4pi.com>, linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: whacked out 2.2.18pre17?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:15 PM -0600 11/3/2000, Stefan Jeglinski wrote:
[...]
>Well, this is unlike most users of Twin Turbo cards, if the past list
>traffic is any measure. Interestingly, I have seen comments before
>that the issue is not the imsttfb driver, but X itself. This would
>not be inconsistent with your setup, given the debian X. I would love
>to get the twin turbo working, I have been waiting for X4 to get far
>enough along, but it appears to still be lacking in even
>straightforward atyfb support (debugged that is), as per the last I
>read. Older ATI Rage Pro card(s) are what else I have, but it won't
>do me any good to get one card working if another that I have breaks.

>From a kterm 5 seconds ago:

merida:~# cat /proc/fb
0 IMS TT (IBM)
merida:~# uname -a
Linux merida 2.2.17 #8 SMP Sun Oct 29 10:17:32 CST 2000 ppc unknown
merida:~# dpkg -l xserver-fbdev
[...]
ii  xserver-fbdev  3.3.6-11       X server for framebuffer-based graphics driv
merida:~# fbset -x

Mode "1280x1024"
	# D: 135.007 MHz, H: 102.278 kHz, v: 96.126 Hz
	DotClock 135.008
	HTimings 1280 1296 1304 1320
	VTimings 1024 1040 1048 1064
	Flags     "+HSync" "+VSync"
EndMode


Of course, the actual dotclock is really only 105.336 MHz (1280x1024x75Hz),
but the modeline works. 1280x1024x96Hz would be nice, mind you, but I don't
quite think my monitor could take it. ;)


I'm not holding my breath on XF4. I think the project is taking the '86'
part of XFree86 a little too seriously. X is a user program like any other,
it's not a special case where the dividing lines between userland and
kernelspace need to be trampled in broken x86-centric ways.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
