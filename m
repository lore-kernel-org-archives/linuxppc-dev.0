Message-ID: <20011021224211.561.qmail@web13105.mail.yahoo.com>
Date: Sun, 21 Oct 2001 15:42:11 -0700 (PDT)
From: Dave Ray <g4tinker@yahoo.com>
Subject: idebus=133 ?
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It's my understanding the Mac G4 towers run at a bus
speed of 133 MHz. However the kernel argument for
idebus=xx apparently only allows values up to 66. Is
this intentional?

I checked where this was is the kernel source and
manually changed the limit from 66 to to 133 to see
what happens. The machine boots fine with no errors.
The file is: drivers/ide/ide.c. On lines 3159 and 3162
I simply changed "66" to "133". Then I boot with
"idebus=133".

Is the 66 limit intentional or should it be changed to
133?

-Dave


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
