Message-ID: <40E3F73A.60607@iti.fi>
Date: Thu, 01 Jul 2004 14:36:26 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Lite5200 PCI not working
References: <20040701091858.A3564C109F@atlas.denx.de>
In-Reply-To: <20040701091858.A3564C109F@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I've updated the table to include  the  settings  for  the  Rev.  4.0
>board, too, and to list ALL jumpers on the board.
>
>
>
>>OK. Please see http://www.denx.de/twiki/bin/view/DULG/CoralPInstallation
>>
>>
>
>Hope this helps.
>
>

I have Rev 3.0 board with analog switch type EL4331. To get it working
even in bypassed mode
it needs PD ( Power down ) input in pin 14 to grounded ( connect example
to pin 10 ).

With this modification my board works.  I am running Embedded QT but it
looks a like that
#define QT_QWS_REVERSE_BYTE_ENDIANNESS in
qt-embedded-free-3.3.2/src/kernel/qgfxraster_qws.cpp was not enough to get
colours right. Needs just more hacking code for fixing endianes problem.



Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
