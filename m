From: hugh.mcdonald@nokia.com
Message-ID: <4FC68B779807D31191B10008C7731C4D579921@meeis01nok>
To: Ruedi.Hofer@ascom.ch
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: SCC used for WAN connection
Date: Fri, 16 Jun 2000 02:21:16 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 30/5/00 Ruedi Hofer wrote,
>
>I'd like to use one of the currently unused SCC's as WAN interface.
>My ultimate dream is to run PPP or Frame Relay at a speed of
>2Mb/s on it.
>......

Hi Ruedi,
    I too am hoping to one day run one SCC on an MBX860 board as a 2M WAN
port. My general plan was to run the SCC in HDLC synchronous mode and use
the PPP protocol on top of this.  From my quick investigation I found that
in the LinuxPPc /kernel/drivers/char area there some files synclink.c
(rewrite of serial.c) and n_hdlc.c (rewrite of ppp.c). Together they form a
Linux Device Driver & line disipline for a synchrouous PPP link.
Unfortunately the synclink.c driver is dedicated to a PCI serial card
produced by MicroGate.
   What is needed is a new version of 8xx_io/uart.c that sets up and drives
the SCC as a synchronous serial port. This may then be useable with the sync
PPP line disipline from the above driver.
  I have started playing with it but only when I have some spare time....
and I dont seem to get much of that these days :-(

   Please let me know if you get any info from other people or find out any
other possible solutions....

Regards
   Hugh McDonald
   hugh.mcdonald@nokia.com

>-----Original Message-----
>From: EXT Ruedi.Hofer@ascom.ch [mailto:Ruedi.Hofer@ascom.ch]
>Sent: Tuesday, May 30, 2000 1:51 AM
>To: linuxppc-embedded@lists.linuxppc.org
>Cc: kernel@linux01.hasler.ascom.ch
>Subject: SCC used for WAN connection
>
>
>Hi,
>
>I'd like to use one of the currently unused SCC's as WAN interface.
>My ultimate dream is to run PPP or Frame Relay at a speed of
>2Mb/s on it.
>
>Is someone out there, who has
>1. seen something like this?
>2. written some kernel modules which support this functionality?
>3. seen links containing related information?
>4. ideas on how to do this?
>
>If you were doin' something like that, would you first buy a
>WAN Interface
>card for the PC? (eg. Sangoma, for tests?)
>5. Has someone done tests with such a WAN card?
>
>Thanx for any information,
>
>Ruedi
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
