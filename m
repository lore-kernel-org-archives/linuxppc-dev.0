Date: Sun, 12 Aug 2001 14:57:27 +1000
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: serial cable problem (for of output)
Message-ID: <20010812145727.A2927@shiva.marian>
Reply-To: Steven Hanley <sjh@wibble.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All

Okay I am trying to use my serial cable hookup to the modem port on an
oldworld for the first time now.

I have a mac modem to 25 pin serial cable, linked to a null modem (though I
hhave tried without the null modem also) connector, then I have tried plugging
it into the back of a pc, the back of my pismo (with a keyspan usb to serial
cable) and to a serial mouse.

None of these seem to do anything, and I also cant type or see anything when
booting amachine and tryying to get into OF.

What am I doing wrong?

Running minicom with 38400 8N1 on the mac and the pc or pismo, I cant type at
either end or see anything. When i have the mouse plugged in and cat
/dev/ttyS0 or minicom running I also see nothing.

As mentioned  I have tried all this both with and without the null modem
connected in the middle.

        See You
            Steve

--
sjh@wibble.net http://wibble.net/~sjh
Look Up In The Sky
    Is it a bird?   No
        Is it a plane    No
            Is it a small blue banana?
Yes

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
