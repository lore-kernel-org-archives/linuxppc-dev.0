Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158D8E@norcom2.norcom.net>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: pcmcia slot A problem
Date: Fri, 26 Sep 2003 10:03:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

With all you guys help, I got my mpc855 board working with PCMCIA-3.2.5 and
cisco 350 card in slot B. However, the does not work in slot A. It gets
recognized properly (seems to me), but then setup card fails with "BAP setup
failed too many retries". I have also tried 3com 3c589 card and that card
also works in slot B but in slot A, it does not work as well. I have looked
at the resources and they do not seem to be in conflict. I am using
m8xx_pcmcia.c file from 2.4.4 kernel from DENX engineering while my kernel
is 2.4.18.

Any ideas??

Lokesh Kumar
Wireless Matrix USA Inc.
703-262-4032


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
