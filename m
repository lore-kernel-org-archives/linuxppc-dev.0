Message-ID: <5725AF6EE9FAD51195DC009027E377020B656170@az33exm35.corp.mot.com>
From: Milliorn Gary-rxcr80 <Gary.Milliorn@motorola.com>
To: "'Yuxiao Xi'" <xiyuxiao@harbournetworks.com>,
	"Mark A. Greer" <mgreer@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: DINK32 R13.1 on Sandpoint X2
Date: Fri, 5 Sep 2003 12:16:02 -0700 
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C373E2.2558862C"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C373E2.2558862C
Content-Type: text/plain


  You cannot 'ping' DINK as the stack is not persistent.
It is only usable when networking tasks are being
performed.  You might be able to ping it while doing a
tftp, but I wouldn't count on it.

  Use Linux if you want ping working.

Regards,
Gary Milliorn


> -----Original Message-----
> From: Yuxiao Xi [mailto:xiyuxiao@harbournetworks.com]
> Sent: Friday, September 05, 2003 12:07 AM
> To: Mark A. Greer
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: DINK32 R13.1 on Sandpoint X2
>
>
>
> hi,
>     I succeed in downloading my linux kernel image using DINK32 r13.1
> tftp function to my Sandpoint X2 board. Before I used ftp
> servers which
> need user name and password and I could not download anything.Today I
> use Cisco ftp server which needs nothing and I succeed.
>
>     But there are another question yet: when I use command 'ping', to
> ping my target from the host,I get info:destination address
> unreachable
> to ping my host from the target??It's OK why?
>
> >We have an 8139 and have successfully downloaded and run a
> kernel with
> >DINK version 13.1.1.  I didn't do it but the instructions
> sent from the
> >person who did are:
> >
> >    To download via the network, DINK uses fixed IP
> >    address and Realtek8139 NIC. The steps are:
> >
> >    1. do "ppr" verify NIC card has been identified
> vendor/device ID as
> >    10EC/8139
> >    2. do "env IO=COM1:9600@100, Then "reset".
> >    3. do "ni -i " to set up your network parameters.  For example:
> >
> >     DINK32[MPC7457] {1} >>ni
> >     NETWORK INFORMATION
> >       PCI CARD
> >         Type 8139/10EC on slot 16
> >
> >       SETTINGS
> >         SERVER(TFTP) : 192.168.  1.  1
> >         GATEWAY      : 192.168.  1.  1
> >         NETMASK      : 255.255.255.  0
> >         DHCP         : 192.168.  1.  1
> >         CLIENT(DINK) : 192.168.  1.  7
> >
> >       DHCP: Disabled
> >       SESSION TIMEOUT: Never
> >
> >    4. set up you tftp server at host side
> >    5. The download command is "dl -nw -b -o800000
> -fzImage.sandpoint"
> >    6. "go 810000"
> >
> >You can change IP addr, image name, to fit your setup.
> >
> >As far as differences in the X2 vs. X3, yes there are important
> >differences.  Does DINK v13.1.1 run successfully & download via the
> >network successfully on an X2?  I don't know, you'll have to
> figure that
> >out for yourself or talk to Motorola.
> >
> >>     From the mailing lists,I know that someone use DINK32's tftp
> >>download function to download his image successfully on a
> Sandpoint X3
> >>board.Is there any important differences between Sandpoint X3 and X2
> >>board so that I can not use the DINK32's tftp function on X2 board?
> >>
> >>======= 2003-09-03 11:04:00 ?o=======
> >>
> >>>On Tue, Sep 02, 2003 at 05:22:08PM +0800, Yuxiao Xi wrote:
> >>>
> >>>>    Now I'm working on a Motorola Sandpoint X2 board with ppc8240.
> >>>>I use DINK32 r13.1 to boot my linux kernel image. From
> DINK32 r13.1
> >>>>user manual,I know that DINK32 r13.1 supports ethernet
> card Realtek
> >>>>8139,but after these steps:
> >>>>
> >>>What I would suggest is that instead of using the ethernet card
> >>>support, you use the serial support still. DINK32 r13.0.0 and newer
> >>>support 115200 baud, so loading a kernel via serial is now
> much less
> >>>painful than it used to be.
>
> = = = = = = = = = = = = = = = = = = = =
>
> !!!!!!!!!!!!!!!!Yuxiao Xi
> !!!!!!!!!!!!!!!!xiyuxiao@harbournetworks.com
> !!!!!!!!!!!!!!!!!!!!2003-09-05
>


------_=_NextPart_000_01C373E2.2558862C
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

------_=_NextPart_000_01C373E2.2558862C--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
