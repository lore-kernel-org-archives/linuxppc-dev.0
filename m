Date: Wed, 2 Jun 1999 01:07:06 -0600 (MDT)
From: Brad Midgley <brad@turbolinux.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: rsync kernel compile fails
Message-ID: <Pine.LNX.3.95.990602005536.28345A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


is the rsync kernel supposed to be working? i haven't changed my config
but it fails to compile:

make[3]: Entering directory `/mnt/extra/linux-imac/drivers/usb'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -D__powerpc__ -fsigned-char -msoft-float -pipe
-fno-builtin -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -c -o
usb.o usb.c
usb.h: In function `usb_audio_interface':
In file included from usb.c:43:
usb.h:366: parameter name omitted
usb.h:366: parameter name omitted
usb.h: In function `usb_audio_endpoint':
usb.h:367: parameter name omitted
usb.h:367: parameter name omitted
make[3]: *** [usb.o] Error 1
make[3]: Leaving directory `/mnt/extra/linux-imac/drivers/usb'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/mnt/extra/linux-imac/drivers/usb'
make[1]: *** [_subdir_usb] Error 2
make[1]: Leaving directory `/mnt/extra/linux-imac/drivers'
make: *** [_dir_drivers] Error 2

(my config has this in its usb section)


# Universal Serial Bus (USB)

CONFIG_USB=y
# CONFIG_USB_UHCI is not set
CONFIG_USB_OHCI=y
CONFIG_USB_HUBD=y
# CONFIG_USB_AUDD is not set
# CONFIG_USB_HIDD is not set
CONFIG_USB_HIDBP=y
CONFIG_USB_HIDBP_KBD=y
CONFIG_USB_HIDBP_MSE=y
# CONFIG_USB_CDCD is not set
# CONFIG_USB_MSDD is not set

[brad@cricket brad]$ egcs --version
egcs-2.91.66

Brad
brad@pht.com | http://www.pht.com/~brad/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
