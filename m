Message-ID: <39216021.8FF44C3E@motorola.com>
Date: Tue, 16 May 2000 09:50:09 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
To: "Dan A. Dickey" <ddickey@charter.net>
CC: "linuxppc-embedded@lists.linuxppc.org"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to get rom code to go on FADS?
References: <391B220F.9838E70F@charter.net> <391C3273.4BBF0884@motorola.com> <391C3945.9E0A439F@charter.net> <391C5416.15ADA181@motorola.com> <391D5E99.D14A02F2@charter.net> <39201DD2.2135361E@motorola.com> <39202D2C.385DD3B@charter.net> <39203732.AD113B13@charter.net> <39204117.73C9FE3B@charter.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,
  By any chance, do you not have +12V applied?  Also, how are you
programming your Flash ROM?  Try downloading it and reading the
memory locations with MPC8bug (normally MPC8bug puts the Flash
up at 0x02800100), then power off for a minute or two, then
reset the board normally through MPC8bug and read the memory
locations again.  It almost sounds like your Flash isn't getting
programmed at all...

Do an mdi at 0x02800100 to see if your code is properly getting
programmed.  I've got a feeling that I might know what's going on.

"Dan A. Dickey" wrote:
>
> Ok, I've now learned that even a simple:
>
> _start:
>         b       _start
>
> fails with the development port interrupt.
> Really odd...
>         -Dan

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
