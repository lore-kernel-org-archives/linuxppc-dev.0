Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20010721101345.5964.qmail@web20104.mail.yahoo.com>
Date: Sat, 21 Jul 2001 03:13:45 -0700 (PDT)
From: John Francis <johnfrancsis@yahoo.com>
Subject: Interfacing user application and interrupt.
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a situation where one of the controller on my
board can generate interrupt which I am planning to
use as a signal for a user process to go and read some
data from "serial port or socket".

How is this task commonly done?

What I want to happen is

A *UNIX user process* waits for interrupt to go off.
When the interrupt is generated it goes and reads from
/dev/tty or a socket.

I also have ppc linux interrupt handler that correctly
detects the interrupt from the device. Now what I am
missing is how does the kernel interrupt handler
indicate to the user process that  there was an
interrupt and user process needs to do its thing....

Any pointers on how to do this properly?

-John

Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
