MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: linux-2.4.18 & copy-back cache mode
Date: Thu, 7 Mar 2002 16:18:04 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F096A96@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <laurent.pinchart@capflow.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am sorry. I meant 64Mhz , not 66Mhz.

Navin.

-----Original Message-----
From: Navin Boppuri
Sent: Thursday, March 07, 2002 2:33 PM
To: linuxppc-embedded@lists.linuxppc.org
Cc: laurent.pinchart@capflow.com
Subject: RE: linux-2.4.18 & copy-back cache mode



I am running my MPC855T at 66Mhz 1:1 CPU/bus clock mode without any problems. I used an app. note from Motorola to do this and according to the app.note, we just need to satisfy some timing constraints on the processor (latency of data reaching the MPC pins from SDRAM). The app. note suggests using specific Micron SDRAM which satisfy all these requirements.

Navin.

-----Original Message-----
From: Dan Malek [mailto:dan@embeddededge.com]
Sent: Wednesday, March 06, 2002 1:50 PM
To: Wolfgang Denk
Cc: laurent.pinchart@capflow.com; linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode



Wolfgang Denk wrote:

> There are no differences AFAIK. It's just a faster CPU that allows 66
> or even 76 MHz with 1:1 CPU/bus clock mode.

Interesting.  Faster than 50 MHz cores used to require the 2:1 bus
clock division.  I don't remember timing parameters that would
exceed 50 MHz.  Yes, the part will let you do that, but I thought that
was outside of the part specification.  I guess I'll have to take a look.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
