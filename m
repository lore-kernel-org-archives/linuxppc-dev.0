Date: Wed, 6 Jan 1999 19:38:13 +0100
To: debian-powerpc@lists.debian.org, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: [ANN] New test kernel available
Message-Id: <19990106193813.032518@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello !

I've uploaded to my web page (see URL below) a new test kernel along with
it's modules and diff's.

This kernel contains some personal patches, some of them experimental,
other quite robust, plus the IDE improvement suggested by Paul recently
on the linuxppc-dev mailing list :

 - Improve support for 3 buttons mice and PowerBook trackpad

 - Implements L2CR (backside cache) setting via BootX for G3 upgrade cards
   (needs BootX 1.0.1 minimum)

 - Adds support for backlight buttons on PowerBook G3 Series (it also turns
   off backlight when the console screen saver blanks the display). This
   used to work only on older PowerBooks. Note: currently the backlight
buttons
   won't auto-repeat. The backlight value is stored in nvram in the same
   location as MacOS and so should be compatible with MacOS setting. 
 
 - Some cleanups here or there (gatwick interrupt fixing, power control
of modem
   in macserial.c, ...)

 - Sets the correct value in the IDE controller to enable full speed of IDE
   transfer on heathrow-based machines.


Note: This kernel includes built-in Adaptec and NCR53C8XX drivers and
DDP. The modules contains smbfs. PCMCIA is not included. 

I tested it on a PowerBook G3 Series and a PowerMac G3/300 without
problem. Be careful however since some of this stuff is experimental.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
