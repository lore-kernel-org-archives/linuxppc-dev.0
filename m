Message-Id: <200309190129.UAA15884@lists.linuxppc.org>
From: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
To: Kumar Gala <kumar.gala@motorola.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: question about UART ST16C2552
Mime-Version: 1.0
Content-Type: text/plain
Date: Fri, 19 Sep 2003 09:39:23 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes,I have an external DUART ST16C2552.
Kumar,should ST16C2552 be detected as 16550A?
When and where can I get the patch for the on-chip UART you said?
Thanks.

> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@motorola.com]
>Thanks for the correction.  I guess my comments really apply to 8241,
>8245 and 8540 then.
>
>On Thursday, September 18, 2003, at 11:23 AM, Milliorn Gary-rxcr80 wrote:
>
>>  There is no DUART on the MPC8240, if 8240 is what he literally
>> meant. Some boards, like Unity, used to have an external DUART
>> for this reason.
>>
>> > -----Original Message-----
>> > From: Kumar Gala [mailto:kumar.gala@motorola.com]
>> > Sent: Thursday, September 18, 2003 11:01 AM
>> > Subject: Re: question about UART ST16C2552
>> >
>> > For 824x the detection code for the on-chip UART does NOT currently
>> > detect it as a 16550A.  There is a patch that Tom Rini and I are
>> > working on getting accepted by the serial maintainers, that should
>> > fix this.
>> >
>> > However, its not clear to me from your email if you also have a
>> > ST16C2552 in addition to the DUART on the 8240.

¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡Yuxiao Xi
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡xiyuxiao@harbournetworks.com
¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡¡2003-09-19

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
