Message-ID: <3A3E2D52.BB40FB3F@siemens.at>
Date: Mon, 18 Dec 2000 16:29:22 +0100
From: Rainer Kloud <rainer.kloud@siemens.at>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: tty_ioctl
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a problem with the console output of my init process.

I'm useing a statically linked sash which tries to determine if
the used file descriptor is associated to a terminal device.
Therefore it uses isatty(STDIN). This library function invokes
the kernel routine tty_ioctl with the command TCGETS.
Now my problem is that this command is not defined in tty_ioctl
and so this routine returns an error.

I have seen, that this command is defined in n_tty_ioctl.
Whow is the relationship between this two ioctl commands?
How can I solve this problem?

Also I can not print any message from the init process (neither
the sash version nor the sash prompt). Any ideas?

Thank you in advance!

Rainer

PS: Im useing the kernel version 2.4.0-test10 with gcc 2.95.2 and
glibc 2.1.3 on a motorola scout board (MPC750/MPC8260).

--
Rainer Kloud               mailto:rainer.kloud@siemens.at
Siemens AG, PSE ECT OTN 2, Rampengasse 3-5, A-1190 Vienna
Phone: +43-(0)51707-43873         Fax: +43-(0)51707-53581

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
