Message-ID: <002c01c2c287$25d5b050$5e207aa1@fish>
From: "Jason Park" <jason@amadeus.kist.re.kr>
To: "Rod Boyce" <rod_boyce@stratexnet.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <8D7C5F56B409554D9D46AC22195807F3061C2A@exchwenz01.dmcwave.co.nz>
Subject: Re: Problem with BDI2000 flash programming
Date: Thu, 23 Jan 2003 11:28:12 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


thanks.

i figured out my problem.. it was in the cfg file..

i didn't have the [HOST] configured properly to
access the ppcboot.bin file.. only the ppcboot.srec file.

simple answer to a simple problem.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
