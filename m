Date: Fri, 20 Oct 2000 12:18:26 +0200
From: Olaf Hering <olh@suse.de>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB-Mouse
Message-ID: <20001020121826.C21610@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <Pine.OSF.4.02.10010190958400.3355-100000@ax1305.physik.uni-marburg.de> <Pine.GSO.4.21.0010191518150.27486-100000@stekt6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0010191518150.27486-100000@stekt6>; from tkanerva@ees2.oulu.fi on Fri, Oct 20, 2000 at 11:18:43AM +0300
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 20, Topi Kanerva wrote:

> guys, how exactly do you make it to work?

Put that in boot.local:

echo "1"  > /proc/sys/dev/mac_hid/mouse_button_emulation
echo "87" > /proc/sys/dev/mac_hid/mouse_button3_keycode # F11
echo "88" > /proc/sys/dev/mac_hid/mouse_button2_keycode # F12


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
