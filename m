Message-ID: <4106E076.60500@esteem.com>
Date: Tue, 27 Jul 2004 16:08:38 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: okorpil@fh-landshut.de
Cc: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.com>,
	Mark Chambers <markc@mail.com>,
	"Wells, Charles" <Charles.Wells@NielsenMedia.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux is not reliable enough?
References: <37D0F88E70D96C428C19EEB865701A38027D1105@buda902a.siemens.hu> <41068C9A.1000806@fh-landshut.de>
In-Reply-To: <41068C9A.1000806@fh-landshut.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oliver Korpilla wrote:
>
> Mészáros Lajos wrote:
>
>>
>> Yes, 'C' is unreliable because writing beyond the "maxindex" lets
>> you overwrite other's data, other's code and DOES make backdoor for
>> viruses.
>>
>> On the other hand testing every index every time for min and max slowes
>> the executing.
>
>
> QNX does not, and Linux does not, and with both C is as unreliable as ever.
>
> However, a failure in a QNX in the driver level is not as potentially
> malicious as in Linux. While this does not exclude failure, and does not
> say a thing about the actual quality of QNX or Linux code, it's a nice
> _additional_ feature related towards stability.
>
> I guess Linux lacking proper certification for some applications is a
> much bigger obstacle in the minds of managers, anyway.
>
> But somehow this is getting offtopic, quickly, isn't it?
>
> With kind regards,
> Oliver Korpilla
>

	If C is not reliable enough then nothing is. In assembly(or even
handcoded machine language for the real hard core people) you can do
just about anything. Since all languages must resort to this at some
point, our foundation is built on sand and we are eternaly screwed.

	Only the 4 last words of the last sentence of this statement is false.
Its not the languages job to write good solid code or verify it, its the
programmers responsibility. The only code you can truly trust is code
you have total control over. For truly solid code, no funky error
checking computer science language will ever replace good practices,
thorough testing, and documentation.

	The reason for this is obvious, at some point higher level languages
must be built using a lower language to avoid the chicken/egg paradox.
Hence the quality of a higher level language can never be assured since
its foundation is made of sand.

Its a poor musician that blames their instrument.

-- Conn Clark

*****************************************************************
Give a man a match and you heat him for a moment. Set him on fire
and you'll heat him for life.
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
