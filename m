Date: Tue, 8 May 2001 17:14:39 +1000
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: cant set port_type in new airport driver
Message-ID: <20010508171439.A1386@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

in ben's old driver for the airport I was able to do
modprobe airport port_type=3
to set the Mode to Ad-hoc rather than managed.

however if the card is already in Managed mode
iwconfig airport mode Ad-hoc
will fail

now in the new driver I can no longer pass the port_type as a paramater to the
modprobe (it isnt in the sources for airport.c orinoco.c or hermes.c) and yet
you still can not change to Ad-hoc mode with iwconfig, the sourced in
orinoco.c for the ioctl to set the mode still are the same effectively.

So doe sanyone know how to set the mode to Ad-hoc in the new airport driver? I
cant use Managed as I dont use a base station, I use another card in another
computer also in Ad-hoc mode and set up a cipe link over the link.

        See You
            Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
