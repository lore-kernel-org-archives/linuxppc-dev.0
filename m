From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: yellowdog-general@lists.yellowdoglinux.com,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Yet Another New Version of Xpmac (Revision 9)
Date: Sat, 22 Jan 2000 10:14:38 -0500
Content-Type: text/plain
Cc: debian-powerpc@lists.debian.org
MIME-Version: 1.0
Message-Id: <00012210225200.00497@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have just posted the latest version (revision 9) of Ryuichi Oikawa's Xpmac
Xserver which is accelerated for Rage128 and Mach64.   This version has support
for usb mice as well as adb mice.

This is a bugfix release:

- includes fix to allow auto vt switching for Mac-On-Linux (MoL) users

- fix for seg-faults during Xpmac startup for machines that don't have
  /dev/usbmouse


***Please upgrade to at least Xpmac revision 8 because of bug fixes for serious
usbmouse problems that can cause hangs, lost mouse clicks, etc****

Please give it a try and let me know if you run into problems:
AFTER making sure you have tried everything in the ReadThisFirst.txt file!).

The URL's given below are on my work desktop workstation which I need to do
my research and can't handle a big load so please check at Robert Shaw's G3 site
http://www.linuxppc.org/blueg3/ first for revision 9 before downloading it from
the URL's given below.

(ps. I have not given Robert much of a head's up (again!) so if
you can wait a day or so it should soon appear on his site).

The URLs are:

ftp://khendricks.ivey.uwo.ca/pub/
http://khendricks.ivey.uwo.ca/rage128_usb/

If you have trouble downloading this file using netcape, remember to use the
right mouse button (or under MacOS click and hold the link to download the file
as source (versus text).).  Note, some netscapes automagically gunzip the file
for you without removing the .gz from the name.  Check the file sizes to be
sure what your netscape does.

Have fun!

Kevin


p.s. If you need or want the source, e-mail me directly and I would be happy to
send it to you as an e-mail attachment.  To build the source, you must place
it in the XFree 3.3.5 source tree to replace the original powermac
directory using Tom Rini's ppc source rpm.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
