Message-ID: <006d01c444b7$cf57d3c0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "David Ho" <DavidHo@nanometrics.ca>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <OFA7FE93B3.1BAFEB05-ON85256EA2.0044EB60-85256EA2.00457969@nanometrics.ca> <40B73451.4080001@intracom.gr>
Subject: Re: RTC no longer exist on the 866/87x/88x
Date: Fri, 28 May 2004 09:29:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >I know the /dev/rtc still uses RTC on the processor, it appears to work
> >fine, but I wouldn't bet my life on it for production units.
> >

It may simply be a testing issue:  I was told by a Motorola rep that there
are two things responsible for the cost of an IC (other than the size of the
die) - the cost of the packaging and the cost of test.  So some of these 8xx
variants are simply minimally tested versions of the parent processor.  Or
in the case of the 852, some pins that aren't connected.

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
