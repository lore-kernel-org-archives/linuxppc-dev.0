Message-ID: <023901bfd7f1$96254ba0$d0c809c0@p2kasvr>
Reply-To: "john zhan" <r3587@sina.com>
From: "john zhan" <r3587@sina.com>
To: <hugh.mcdonald@nokia.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <4FC68B779807D31191B10008C7731C4D579921@meeis01nok>
Subject: Re: SCC used for WAN connection
Date: Sat, 17 Jun 2000 08:16:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi, Hugh McDonald

> On 30/5/00 Ruedi Hofer wrote,
> >
> >I'd like to use one of the currently unused SCC's as WAN interface.
> >My ultimate dream is to run PPP or Frame Relay at a speed of
> >2Mb/s on it.
me too.  in fact,   also, I need generic x.25 running on it.

>Hugh McDonald wrote,
> Hi Ruedi,
>     I too am hoping to one day run one SCC on an MBX860 board as a 2M WAN
> port. My general plan was to run the SCC in HDLC synchronous mode and use
> the PPP protocol on top of this.  From my quick investigation I found that
> in the LinuxPPc /kernel/drivers/char area there some files synclink.c
> (rewrite of serial.c) and n_hdlc.c (rewrite of ppp.c). Together they form a
> Linux Device Driver & line disipline for a synchrouous PPP link.
> Unfortunately the synclink.c driver is dedicated to a PCI serial card
> produced by MicroGate.
yes , we NEED a SCC HDLC mode synchronous  driver.

>    What is needed is a new version of 8xx_io/uart.c that sets up and drives
> the SCC as a synchronous serial port. This may then be useable with the sync
> PPP line disipline from the above driver.
>   I have started playing with it but only when I have some spare time....
great!
I think it will probably  have big difference from the existing uart.c , and init routine must contain of  both uart and hdlc init code.
or ,  maybe need reconstruct the directory/file structures , add hdlc.c which supports full features of net device.

> and I dont seem to get much of that these days :-(
>    Please let me know if you get any info from other people or find out any
> other possible solutions....
I think we can  work together .
If you like,let's discuss it later , privately.

what do you say?

regards.
john zhan.
hacking time.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
