Message-ID: <3C9ED7CE.AF54E6BB@imc-berlin.de>
Date: Mon, 25 Mar 2002 08:54:54 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Navin Boppuri <navin.boppuri@newisys.com>
Cc: "Ppcboot-Users (E-mail)" <ppcboot-users@lists.sourceforge.net>,
	"Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: External TA assertion timing on GPCM
References: <D3A72C5007329A4F991C0DD87202259F0EAFD7@sekhmet.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin,

I quotr from MPC860 User Man. Chapter 11.6 Bus Monitor
"...The timing mechanism is clocked by the system clock devided by
eight. The maximum value is 2040 system clocks..."

The bus monitor timing is set in Bits 16-23 of SYPCR.

Hope this helps,

Steven


>I would like to know if there is a maximum limit from the time CS is asserted (during a read/write operation) till TA is asserted by the device externally.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
