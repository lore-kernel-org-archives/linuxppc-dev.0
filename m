Message-ID: <5725AF6EE9FAD51195DC009027E377020B6561A7@az33exm35.corp.mot.com>
From: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
To: "Gala Kumar K.-galak" <kumar.gala@motorola.com>,
	Yuxiao Xi <xiyuxiao@harbournetworks.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: question about UART ST16C2552 
Date: Thu, 18 Sep 2003 09:23:31 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C37E00.F9F21EC0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C37E00.F9F21EC0
Content-Type: text/plain

Kumar,

  There is no DUART on the MPC8240, if 8240 is what he literally
meant.  Some boards, like Unity, used to have an external DUART
for this reason.

Gary Milliorn



> -----Original Message-----
> From: Kumar Gala [mailto:kumar.gala@motorola.com]
> Sent: Thursday, September 18, 2003 11:01 AM
> To: Yuxiao Xi
> Cc: linuxppc-embedded
> Subject: Re: question about UART ST16C2552
>
>
>
> For 824x the detection code for the on-chip UART does NOT currently
> detect it as a 16550A.  There is a patch that Tom Rini and I are
> working on getting accepted by the serial maintainers, that should fix
> this.
>
> However, its not clear to me from your email if you also have a
> ST16C2552 in addition to the DUART on the 8240.
>
> - kumar
>
> On Wednesday, September 17, 2003, at 08:37 PM, Yuxiao Xi wrote:
>
> >
> > Hi,all,
> >     Does Linux support UART ST16C2552 ?
> >     There is a UART ST16C2552 on my board with CPU ppc8240.
> > While the linux system booting,sometimes function autoconfig(struct
> > serial_state * state) in ./drivers/char/serial.c detected
> ST16C2552 as
> > 16450,sometimes as 8250,can anyone tell me why?
> >
> > !!!!!!!!!!!!!!!!Yuxiao Xi
> > !!!!!!!!!!!!!!!!xiyuxiao@harbournetworks.com
> > !!!!!!!!!!!!!!!!!!!!2003-09-18
> >
>
>
>


------_=_NextPart_000_01C37E00.F9F21EC0
Content-Type: application/octet-stream;
	name="Gary Milliorn (E-mail).vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="Gary Milliorn (E-mail).vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpOOk1pbGxpb3JuO0dhcnkNCkZOOk1pbGxpb3JuIEdh
cnktcnhjcjgwDQpPUkc6MTAwNjA5ODU7U0Q2NDYNClRFTDtXT1JLO1ZPSUNFOjUxMjk2NjcwNjYN
CkFEUjtXT1JLO0VOQ09ESU5HPVFVT1RFRC1QUklOVEFCTEU6O1RYMzIvUEw0NDtNT1RPUk9MQSBJ
TkMuPTBEPTBBNzcwMCBXLiBQQVJNRVIgTEFORTtBVVNUSU47VEVYQVM7Nzg3Mjk7VU5JVEVEID0N
ClNUQVRFUw0KTEFCRUw7V09SSztFTkNPRElORz1RVU9URUQtUFJJTlRBQkxFOlRYMzIvUEw0ND0w
RD0wQU1PVE9ST0xBIElOQy49MEQ9MEE3NzAwIFcuIFBBUk1FUiBMQU5FPTBEPTBBQVVTVElOLCBU
RVhBUyA3ODc9DQoyOT0wRD0wQVVOSVRFRCBTVEFURVMNCkVNQUlMO1BSRUY7SU5URVJORVQ6R2Fy
eS5NaWxsaW9ybkBtb3Rvcm9sYS5jb20NClJFVjoyMDAyMTEwNFQyMTU0MjlaDQpFTkQ6VkNBUkQN
Cg==

------_=_NextPart_000_01C37E00.F9F21EC0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
