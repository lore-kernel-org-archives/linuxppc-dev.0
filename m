MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: External TA assertion timing on GPCM
Date: Tue, 26 Mar 2002 10:44:56 -0600
Message-ID: <D3A72C5007329A4F991C0DD87202259F096ABD@sekhmet.ad.newisys.com>
From: "Navin Boppuri" <navin.boppuri@newisys.com>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>
Cc: "Ppcboot-Users (E-mail)" <ppcboot-users@lists.sourceforge.net>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks guys. The answer was very helpful.

Navin.

-----Original Message-----
From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Sent: Monday, March 25, 2002 1:55 AM
To: Navin Boppuri
Cc: Ppcboot-Users (E-mail); Linuxppc-Embedded (E-mail)
Subject: Re: External TA assertion timing on GPCM


Navin,

I quotr from MPC860 User Man. Chapter 11.6 Bus Monitor
"...The timing mechanism is clocked by the system clock devided by
eight. The maximum value is 2040 system clocks..."

The bus monitor timing is set in Bits 16-23 of SYPCR.

Hope this helps,

Steven


>I would like to know if there is a maximum limit from the time CS is asserted (during a read/write operation) till TA is asserted by the device externally.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
