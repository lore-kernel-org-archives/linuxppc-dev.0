Message-ID: <E1836A7F3557D311A14000805F9F36FCD4E41D@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: tty buffer size
Date: Mon, 27 Aug 2001 20:32:53 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

Is it possible to receive up to 1k characters under
one serial port interrupt? My current product needs
to receive a greater number of characters than that
specified by the TTY_FLIPBUF_SIZE.

I've been playing around with this and if I set the
RX_BUF_SIZE to 256 I can get it to receive
that many characters OK. I can even make it
skip the BH until the flip buffer is full but cannot
get greater than the 512 bytes specified. When
I tried to set TTY_FLIPBUF_SIZE to 1024,
I got a resulting kernel panic upon the next
reboot.

Thanks for any and all help.

Regards,
     Michael Pergola
     Software Engineer
     Danfoss Air-Conditioning & Refrigeration Division
     7941 Corporate Blvd.
     Baltimore, MD  21236     (410) 931-8250 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
