Message-ID: <37AE75AB.8F2C8EAF@cable.a2000.nl>
Date: Mon, 09 Aug 1999 08:31:07 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
CC: otto@cable.a2000.nl
Subject: Keyspan SX serial card driver project
References: <199908090459.XAA08774@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am currently working on a driver for my Keyspan SX serial PCI card. It is
very early in development, but I like to get feedback as soon as possible. So I
have some questions to you all:

- do you have this serial card or its kind (Keyspan SX2, SX4 or SX Pro)?
- do you feel the need to use this card when running LinuxPPC on your Mac (and
maybe even other boxes?)
- Are you running linuxPPC 2.2.10 and are you able to recompile the kernel?
- Are you willing to spend time as a (pre-)alpha tester and later as a beta
tester?
- Do you mind some kernel panics when doing this?

If you can answer the first two questions as 'yes' and the last three as 'no'
or 'maybe', I'd like to hear from you. If you can answer the first four
questions as 'yes' and the last as 'no', I certainly like to hear from you!

These serial cards are a tiny bit different from other serial PCI cards.
Currently I am capable of detecting my SX2 card, doing a loop back test and a
UART type probe (4 uarts on my 2 port card, time to get a soldering iron ;-)).
The development of the actual driver has to begin yet, but it looks like a
slight adaptation of the standard PC serial driver may do the trick.

Greetings,
Otto

--
Otto Moerbeek
otto@cable.a2000.nl

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
