Date: Wed, 18 Apr 2001 14:04:21 +1000
From: Steven Hanley <sjh@svana.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF4, SysRq, VT, mouse buttons, Keymaps and all that
Message-ID: <20010418140421.C535@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20010418002843.8305BDBACB@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010418002843.8305BDBACB@atlas.valhalla.net>; from iain@sandoe.co.uk on Wed, Apr 18, 2001 at 01:28:52AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 18, 2001 at 01:28:52AM +0100, Iain Sandoe wrote:
> The frustration is that the keycodes are listed in
> /proc/sys/dev/mac_hid/mouse_buttonX_keycode - but finding out which physical
> key combination relates to the numbers doesn't appear to be trivial.

AFAIU the numbers there are identical to those in
/usr/src/linux/include/linux/input.h even when you have adb keycodes theya
re still the linux keycode numbers.

if you have the linux keycodes enabled using showkey in console will give
you the keycode for a key corresponding to what is in that header file.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
