Message-ID: <3B3A252F.7070906@mvista.com>
Date: Wed, 27 Jun 2001 11:25:51 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: "Pergola, Michael" <MichaelPergola@Danfoss.com>
Cc: "'Wolfgang Denk'" <wd@denx.de>,
	Friedlander Paul <PaulFriedlander@Danfoss.com>,
	Hihn Jason <JasonHihn@Danfoss.com>,
	"Support (E-mail)" <techsupport@embeddedplanet.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial Port problem with 823e on Embedded Planet
References: <E1836A7F3557D311A14000805F9F36FCD4E385@usdfo011.usac.danfoss.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pergola, Michael wrote:


>>You could switch to use SCC's instead. We have a modified driver that
>>supports full HW handshake on all SCC's (and you  can  configure  the
>>number and size of I/O buffers to optimize for throughput).
>>
>>
> 	[Pergola, Michael]  Is that  the patch commproc.c.patch.gz dated
> 	07/20/2000?
>
>
>


If you use both SCCs for uarts, you lose ethernet.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
