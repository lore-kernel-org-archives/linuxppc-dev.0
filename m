From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Date: Tue, 12 Dec 2000 11:50:14 +0100
Content-Type: text/plain;
  charset="US-ASCII"
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
References: <Pine.GSO.4.10.10012121010320.1109-100000@escobaria.sonytel.be>
In-Reply-To: <Pine.GSO.4.10.10012121010320.1109-100000@escobaria.sonytel.be>
Subject: Re: Mac/m68k patches?
MIME-Version: 1.0
Message-Id: <00121211501400.01036@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 12 December 2000 10:12, Geert Uytterhoeven wrote:
> Hi,
>
> I have these Mac/m68k patches in my patchqueue which affect PowerMac as
> well. Anyone who has a problem with them, or can I send them to Linus?
>
> diff -urN linux-2.4.0-test12/drivers/input/keybdev.c
> linux-m68k-2.4.0-test12/drivers/input/keybdev.c ---
> linux-2.4.0-test12/drivers/input/keybdev.c	Fri Jul 28 03:36:54 2000 +++
> linux-m68k-2.4.0-test12/drivers/input/keybdev.c	Tue Dec 12 09:02:47 2000 @@
> -90,7 +90,7 @@
>  	return 0;
>  }
>
> -#elif defined(CONFIG_ADB_KEYBOARD)
> +#elif defined(CONFIG_INPUT_ADBHID)
>
>  static unsigned char mac_keycodes[128] =
>  	{ 0, 53, 18, 19, 20, 21, 23, 22, 26, 28, 25, 29, 27, 24, 51, 48,

This one is wrong, the right patch is in bk_2_3 and has been feeded to Linus
already, see my post on l-k last week. You can however trigger Linus again to
finally apply it :-). The patch to adbhid.c is fine with me.

I can't talk about the rest of the patch though.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
