From: Ruedi.Hofer@ascom.ch
Date: Tue, 02 May 2000 16:08:58 +0100 (CED)
Subject: Antwort: Re: Antwort: Re: FEC on the MPC860T
To: pohland@snom.de, linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0FTX0022ORB1NU@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_Dtx7X0g4/9tFElMAOSRYmw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_Dtx7X0g4/9tFElMAOSRYmw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi

Well, both led's are working. When I ping from my host to the target,
I can only see the RX led blink. However, after some time I see
the host's MAC address in the arp table on the target.

When I ping from the target to the host, both RX and TX leds blink.

It seems as if the target only accepts broadcast MAC frames....

Any further idea?

What kind of kernel are you using? 2.2.13? Montavista?

Ruedi






pohland@snom.de on 02.05.2000 14:35:34
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie:
Thema: Re: Antwort: Re: MPC860T

Ruedi.Hofer@ascom.ch wrote:
>
> Hi Nicolas

Looks like you are progressing ...

Do not enable DEBUG messages - I believe that they f... things up.


Do you see the RX and TX leds working ?

Cheers,
Nicolas

>
> Thanx for the file. It gets me a bit further...
>
> When I output the event register in case of an interrupt, I get:
>
> while booting:
>
> eth0: CPM ENET Version 0.2, 08:00:3e:26:15:59
> disabling IRQ7.
> FEC int: 0x00a00000
> eth1: FEC ENET Version 0.1, FEC int: 0x00a00000
> FEC int: 0x00a00000
> FEC int: 0x00a00000
> FEC int: 0x00a00000
> fec: link up
> 08:FEC int: 0x00a00000
> FEC int: 0x00a00000
> fec: 10 Mbps, Half-Duplex
> FEC int: 0x00a00000
> 00:3e:26:15:5a
> Sending BOOTP and RARP requests....
>
> -> U-Bus error ?!?  Somehow a cache problem? Which kernel are you using?
>
> and afterwards:
>
> sh-2.03# ping 10.1.30.1
> PING 10.1.30.1 (10.1.30.1): 56 data bytes
> FEC int: 0x0c200000
> FEC int: 0x0c200000
> FEC int: 0x0c200000
> FEC int: 0x0c200000
> FEC int: 0x0c200000
> FEC int: 0x0c200000
>
> 0x0c...: Data sent ok
> 0x002..: Does NOT exist in my databook!!!!
>
> It seems that I'm able to send data, but can't receive any.
>
> Ideas?
>
> Ruedi
>
> pohland@snom.de on 28.04.2000 18:03:39
> An: Ruedi.Hofer@ascom.ch @ MailGate
> Kopie:
> Thema: Re: MPC860T
>
> This is what I came up with when I fixed the bugs ... only 10 MBit/s. If
> you improve it
> please send it back. My BCSR regs are manipulated in a different area.
> You might have to add
> this code.
>
> Cheers,
> Nicolas



--Boundary_(ID_Dtx7X0g4/9tFElMAOSRYmw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
