Date: Thu, 18 Sep 2003 11:00:56 -0500
Subject: Re: question about UART ST16C2552 
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
To: "Yuxiao Xi" <xiyuxiao@harbournetworks.com>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <200309180127.UAA09566@lists.linuxppc.org>
Message-Id: <49B80398-E9F1-11D7-8529-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For 824x the detection code for the on-chip UART does NOT currently
detect it as a 16550A.  There is a patch that Tom Rini and I are
working on getting accepted by the serial maintainers, that should fix
this.

However, its not clear to me from your email if you also have a
ST16C2552 in addition to the DUART on the 8240.

- kumar

On Wednesday, September 17, 2003, at 08:37 PM, Yuxiao Xi wrote:

>
> Hi,all,
>     Does Linux support UART ST16C2552 ?
>     There is a UART ST16C2552 on my board with CPU ppc8240.
> While the linux system booting,sometimes function autoconfig(struct
> serial_state * state) in ./drivers/char/serial.c detected ST16C2552 as
> 16450,sometimes as 8250,can anyone tell me why?
>
> !!!!!!!!!!!!!!!!Yuxiao Xi
> !!!!!!!!!!!!!!!!xiyuxiao@harbournetworks.com
> !!!!!!!!!!!!!!!!!!!!2003-09-18
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
