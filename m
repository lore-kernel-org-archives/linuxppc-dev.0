Date: Thu, 18 Sep 2003 11:29:34 -0500
Subject: Re: question about UART ST16C2552 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Yuxiao Xi <xiyuxiao@harbournetworks.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
To: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
From: Kumar Gala <kumar.gala@motorola.com>
In-Reply-To: <5725AF6EE9FAD51195DC009027E377020B6561A7@az33exm35.corp.mot.com>
Message-Id: <49F075B6-E9F5-11D7-8529-000393DBC2E8@motorola.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the correction.  I guess my comments really apply to 8241,
8245 and 8540 then.

- kumar

On Thursday, September 18, 2003, at 11:23 AM, Milliorn Gary-rxcr80
wrote:

> Kumar,
>
>   There is no DUART on the MPC8240, if 8240 is what he literally
> meant.  Some boards, like Unity, used to have an external DUART
> for this reason.
>
> Gary Milliorn
>
>
>
> > -----Original Message-----
> > From: Kumar Gala [mailto:kumar.gala@motorola.com]
> > Sent: Thursday, September 18, 2003 11:01 AM
> > To: Yuxiao Xi
> > Cc: linuxppc-embedded
> > Subject: Re: question about UART ST16C2552
> >
> >
> >
> > For 824x the detection code for the on-chip UART does NOT currently
> > detect it as a 16550A.  There is a patch that Tom Rini and I are
> > working on getting accepted by the serial maintainers, that should
> fix
> > this.
> >
> > However, its not clear to me from your email if you also have a
> > ST16C2552 in addition to the DUART on the 8240.
> >
> > - kumar
> >
> > On Wednesday, September 17, 2003, at 08:37 PM, Yuxiao Xi wrote:
> >
> > >
> > > Hi,all,
> > >     Does Linux support UART ST16C2552 ?
> > >     There is a UART ST16C2552 on my board with CPU ppc8240.
> > > While the linux system booting,sometimes function autoconfig(struct
> > > serial_state * state) in ./drivers/char/serial.c detected
> > ST16C2552 as
> > > 16450,sometimes as 8250,can anyone tell me why?
> > >
> > > !!!!!!!!!!!!!!!!Yuxiao Xi
> > > !!!!!!!!!!!!!!!!xiyuxiao@harbournetworks.com
> > > !!!!!!!!!!!!!!!!!!!!2003-09-18
> > >
> >
> >
> >
>
>  
>
> <Gary Milliorn (E-mail).vcf>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
