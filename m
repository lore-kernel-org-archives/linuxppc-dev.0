From: ramp@oddjob.uchicago.edu
Date: Sat, 12 Feb 2000 22:24:27 -0600 (CST)
To: "Michael R. Zucca" <mrz5149@acm.org>
cc: a.tobler@schweiz.org, Eric Benard <ebenard@ifrance.com>,
        Paul Mackerras <paulus@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.43 failed
In-Reply-To: <l03130300b4cb698e36a7@[24.218.140.90]>
Message-ID: <Pine.LNX.4.10.10002122212490.4975-100000@xpol.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Paul -
Thanks for the 2.3.44. The compile went smoothly and the machine booted
fine as well but I still continue to have USB keyboard/mouse problems.
>From the USB debug I can see that my keyboard and mouse are being
recognized. But nothing happens when I type or move the mouse. I have
had the same problems with other dev kernels as well. I have tried
unplugging and plugging back the kbd/mouse. Everything works fine
in 2.2.14.

What should my /etc/sysconfig/keyboard and /etc/sysconfig/mouse be?
My current files are
[ramp@localhost ~]$ cat /etc/sysconfig/keyboard
KEYTABLE=
KEYBOARDTYPE="usb"
[ramp@localhost ~]$ cat /etc/sysconfig/mouse
MOUSETYPE="Busmouse"
XMOUSETYPE="BusMouse"
FULLNAME="Universal Serial Bus 3+ Button Mouse (USB)"
XEMU3=yes

In /dev should I have /dev/usbmouse or /dev/usb/mouse? Currently i have
[ramp@localhost ~]$ ls -l /dev/usbmouse
lrwxrwxrwx   1 root     root           11 Dec 17 18:56 /dev/usbmouse ->
hidbp-mse-0
[ramp@localhost ~]$ ls -l /dev/hidbp-mse-0
crw-r--r--   1 root     root      10,  32 Apr 30  1999 /dev/hidbp-mse-0
Should there be a /dev/keyboard or some such?

Help please. This is killing me - Ram

PS: I just used the default pmac_config on my Rev D iMac. In the linux-usb
site the howto says that one should not set HIDBP. But the defaults in the
.config are set to HIDBP?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
