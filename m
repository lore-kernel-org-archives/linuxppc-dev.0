Message-ID: <41068C9A.1000806@fh-landshut.de>
Date: Tue, 27 Jul 2004 19:10:50 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.com>
Cc: Mark Chambers <markc@mail.com>,
	"Wells, Charles" <Charles.Wells@NielsenMedia.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux is not reliable enough?
References: <37D0F88E70D96C428C19EEB865701A38027D1105@buda902a.siemens.hu>
In-Reply-To: <37D0F88E70D96C428C19EEB865701A38027D1105@buda902a.siemens.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mészáros Lajos wrote:
>
>Yes, 'C' is unreliable because writing beyond the "maxindex" lets
>you overwrite other's data, other's code and DOES make backdoor for
>viruses.
>
>On the other hand testing every index every time for min and max slowes
>the executing.

QNX does not, and Linux does not, and with both C is as unreliable as ever.

However, a failure in a QNX in the driver level is not as potentially
malicious as in Linux. While this does not exclude failure, and does not
say a thing about the actual quality of QNX or Linux code, it's a nice
_additional_ feature related towards stability.

I guess Linux lacking proper certification for some applications is a
much bigger obstacle in the minds of managers, anyway.

But somehow this is getting offtopic, quickly, isn't it?

With kind regards,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
