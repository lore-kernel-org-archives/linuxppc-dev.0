Message-ID: <3AE00D10.DB8A1202@inn.ericsson.se>
Date: Fri, 20 Apr 2001 12:18:56 +0200
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: byf <byfmail@yeah.net>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can I use RiscWatch to load ppcboot?
References: <20010419015349.90F841CA867CB@smtp.yeah.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


byf wrote:

> Hello,
>
> I am working for walnut 405GP, it has a ROM Monitor and RiscWatch.
> now I want to use PPCBoot to overwrite ROM Monitor,
> Can I use RiscWatch to load PPCBoot to flash or to ram and run it?
>

yes. I use the onboard SRAM walnut has a switch that exchange the flash and
sram address. So once you load it you can actually reset the machine and it
will boot just like you had programmed a real flash just don't tun the power
off :)

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
