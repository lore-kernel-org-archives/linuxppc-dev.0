Message-ID: <40D6ECB0.6040301@iti.fi>
Date: Mon, 21 Jun 2004 17:12:00 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Gerhard Jaeger <g.jaeger@sysgo.com>,
	=?ISO-8859-1?Q?I=F1igo_Lopez_?= =?ISO-8859-1?Q?Barranco?= <ilopez@albatros-sl.es>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working
References: <20040621105306.6DBC2C13D3@atlas.denx.de>
In-Reply-To: <20040621105306.6DBC2C13D3@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote

>>One card, that is known to work in this slot is the Intel eepro100 NIC.
>>
>>
>
>Or the Coral-P graphics card :-)
>
>
>
Small notice about Coral-P card. Least one that i have needs separate
-12V to connec to PCI
connector pins. There is no -12V supply on board. The Coral-P does
itself  need
-12V but there is one analog mux in video output that needs -5V that is
generated from -12V.

Other possible problem is that i found with ATI Rage Mobility M1 EVA board
that it's 723 3.3V regulator needed as default +12V to operate.

I also have used sucessfulle Xilinx Spartan2 PCI EVA board and
TI1410 cardbus bridge board without problems.

It  looks a like that wery ccommon problem is that many board needs some
+/-12V
event thay should not.



Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
