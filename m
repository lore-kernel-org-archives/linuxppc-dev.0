Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F0A7020.6030205@tataelxsi.co.in>
Date: Tue, 08 Jul 2003 12:47:52 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: mpc8260: ncurses -> keypad() failing.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We have developed a BRouter and use ncurses for some CUI stuff, like
configuring our router on a custom designed board (ppc 8260) running
eldk linux, kernel is different :-)

When I issue the call keypad(), it returns failure (ERR).
I don't know what the error is. it does not set errno, so I cannot use
perror().
My terminal type is set to
$ export TERM=vt100
$ export TERMINFO=/usr/share/terminfo

I have made sure that /usr/share/terminfo contains v directory and vt100
  files.The same code works in RH 7.2 on i386, where we tested the
functionality.

Any idea/suggestion ?
Thanks for your time.
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
