Return-Path: <soumya.k.s@motorola.com>
Received: from motgate5.mot.com (motgate5.mot.com [144.189.100.105])
	by ozlabs.org (Postfix) with ESMTP id B4A2E689E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 19:32:55 +1100 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate5.mot.com (8.12.11/Motgate5) with ESMTP id k078gZQE009369
	for <linuxppc-embedded@ozlabs.org>; Sat, 7 Jan 2006 01:42:35 -0700 (MST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id k078j9f9026333
	for <linuxppc-embedded@ozlabs.org>; Sat, 7 Jan 2006 02:45:10 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Sat, 7 Jan 2006 16:32:31 +0800
Message-ID: <C82A9B11BE247C4E952DC733EA98DAA10134F94D@ZMY16EXM66.ds.mot.com>
From: "KS Soumya-ask067" <soumya.k.s@motorola.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Help on LXT971 eth initialization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 Hi=20
	Have you tried enabling =20
MPC8260 Communication options->FCC Ethernet option-->Ethernet on FCC1, =
Use MDIO for PHY-->LXT971 PHY support.
Hope this helps.


Best Regards,
Soumya

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of =
linuxppc-embedded-request@ozlabs.org
Sent: Friday, January 06, 2006 7:29 PM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 17, Issue 11

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific than =
"Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. How to compile freescale example programs using eldk?
      (zengshuai@sogou.com)
   2. Help need: Porting Linux to PQ2FADS_ZU board (zengshuai@sogou.com)
   3. Re: [PM-SPAM] Help need: Porting Linux to PQ2FADS_ZU board
      (KokHow Teh)
   4. Re: How to compile freescale example programs using eldk?=20
      (Wolfgang Denk)
   5. Re: Help need: Porting Linux to PQ2FADS_ZU board  (Wolfgang Denk)
   6. Help on LXT971 eth initialization (batsayan.das@tcs.com)
   7. Re: io.h question (Arnd Bergmann)
   8. How to enable PHY (batsayan.das@tcs.com)
   9. Re: How to enable PHY (Mark Chambers)


----------------------------------------------------------------------

Message: 1
Date: Fri, 6 Jan 2006 16:23:54 +0800 (CST)
From: <zengshuai@sogou.com>
Subject: How to compile freescale example programs using eldk?
To: "ppc" <linuxppc-embedded@ozlabs.org>
Message-ID: <6251452.1136535834574.JavaMail.postfix@mx3.mail.sohu.com>
Content-Type: text/plain; charset=3D"GB2312"

I down some freescale example programs at
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=3DMPC8260&=
nodeId=3D02VS0lDFTQJk192977

Device Drivers=20
ID and Description                                   Vendor          ID  =
    Format Size K  Rev # Availability=20
MPC8260API
PowerQUICC II API (Drivers and Examples)=20
Includes support for PCI, AAL2, AAL5, MSP, and more(10/03/2002)   =
FREESCALE   zip   15785   4.0.2    =20

Them aren't linux drvier but for bareboard. How can I compile them using =
eldk?

------------------------------
=CE=D2=CF=D6=D4=DA=CA=B9=D3=C3Sogou.com=B5=C42G=D3=CA=CF=E4=C1=CB=A3=AC=C4=
=E3=D2=B2=C0=B4=CA=D4=CA=D4=B0=C9!=20
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=3Dsogouinv=
itation&s_EMAIL=3Dzengshuai%40sogou.com&username=3Dlinuxppc-embedded&Full=
Name=3Dlinuxppc-embedded&Email=3Dlinuxppc-embedded%40ozlabs.org&verify=3D=
755eff4e640bdcfc57d93cbd8b0a9cb7



------------------------------

Message: 2
Date: Fri, 6 Jan 2006 16:49:50 +0800 (CST)
From: <zengshuai@sogou.com>
Subject: Help need: Porting Linux to PQ2FADS_ZU board
To: "ppc" <linuxppc-embedded@ozlabs.org>
Message-ID:
	<23894955.1136537390660.JavaMail.postfix@mx3.mail.sohu.com>
Content-Type: text/plain; charset=3D"GB2312"

I use ELDK3.1.1(2005-06-07).
There is a u-boot 1.1.3 and a linux 2.4.25 in the eldk.
I has compile u-boot successfully.And it works good.
I has compile kernel successfully too.(make ads8260_config) But it =
doesn't work.

Detail:
-------------------------------------------------------------------------=

U-Boot 1.1.3 (Dec 27 2005 - 19:35:12)

MPC8260 Reset Status: Check Stop, External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4.5x, VCO Div 2, 60x Bus Freq  22-65 , Core Freq =
100-300
 - dfbrg 1, corecnf 0x07, busdf 5, cpmdf 1, plldf 0, pllmf 5
 - vco_out  600000000, scc_clk  150000000, brg_clk   37500000
 - cpu_clk  450000000, cpm_clk  300000000, bus_clk  100000000
 - pci_clk   50000000

CPU:   MPC8260 (HiP7 Rev 13, Mask 0.1 1K49M) at 450 MHz
Board: Motorola PQ2FADS-ZU
DRAM:  32 MB
FLASH:  8 MB
In:    serial
Out:   serial
Err:   serial
Net:   FCC2 ETHERNET
Hit any key to stop autoboot:  0
=3D> printenv
bootdelay=3D5
baudrate=3D115200
ethact=3DFCC2 ETHERNET
ethaddr=3D0A:00:00:00:00:0A
gatewayip=3D172.17.248.1
netmask=3D255.255.255.0
ipaddr=3D172.17.248.244
serverip=3D172.17.248.253
bootcmd=3Dtftp 100000 vmlinux.UBoot; bootm 100000 =
bootargs=3Droot=3D/dev/nfs rw =
nfsroot=3D172.17.248.253:/opt/eldk3/ppc_6xx ip=3D172.17.24 =
8.244:172.17.248.253:172.17.248.253:255.255.255.0:pq2fads::off
stdin=3Dserial
stdout=3Dserial
stderr=3Dserial

Environment size: 398/262140 bytes
=3D> boot
Using FCC2 ETHERNET device
TFTP from server 172.17.248.253; our IP address is 172.17.248.244 =
Filename 'vmlinux.UBoot'.
Load address: 0x100000
Loading: =
#################################################################
         #########################################################
done
Bytes transferred =3D 623547 (983bb hex)
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.25
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    623483 Bytes =3D 608.9 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
-------------------------------------------------------------------------=
----------
At here,it stoped.
Later,I debug the kernel using bdi2000.
I bi start_kernel(),and setp by setp.
But printk(".........) didn't work.

My board is PQ2FADS_ZU.Does the ELDK not support it?


------------------------------
=CE=D2=CF=D6=D4=DA=CA=B9=D3=C3Sogou.com=B5=C42G=D3=CA=CF=E4=C1=CB=A3=AC=C4=
=E3=D2=B2=C0=B4=CA=D4=CA=D4=B0=C9!=20
http://mail.sogou.com/recommend/sogoumail_invite_reg1.jsp?from=3Dsogouinv=
itation&s_EMAIL=3Dzengshuai%40sogou.com&username=3Dlinuxppc-embedded&Full=
Name=3Dlinuxppc-embedded&Email=3Dlinuxppc-embedded%40ozlabs.org&verify=3D=
755eff4e640bdcfc57d93cbd8b0a9cb7



------------------------------

Message: 3
Date: Fri, 6 Jan 2006 17:09:35 +0800
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Subject: Re: [PM-SPAM] Help need: Porting Linux to PQ2FADS_ZU board
To: linuxppc-embedded@ozlabs.org
Message-ID:
	<OFF860A6FA.D61DCEB9-ON482570EE.0031F142@uk.marconicomms.com>
Content-Type: text/plain; charset=3Dus-ascii



>bootargs=3Droot=3D/dev/nfs rw =
nfsroot=3D172.17.248.253:/opt/eldk3/ppc_6xx
ip=3D172.17.24
>8.244:172.17.248.253:172.17.248.253:255.255.255.0:pq2fads::off

add console=3D/dev/ttyS0,115200n8 and see if it works?





------------------------------

Message: 4
Date: Fri, 06 Jan 2006 11:08:44 +0100
From: Wolfgang Denk <wd@denx.de>
Subject: Re: How to compile freescale example programs using eldk?=20
To: zengshuai@sogou.com
Cc: ppc <linuxppc-embedded@ozlabs.org>
Message-ID: <20060106100844.A025D354113@atlas.denx.de>
Content-Type: text/plain; charset=3DISO-8859-1

In message <6251452.1136535834574.JavaMail.postfix@mx3.mail.sohu.com> =
you wrote:
>
> Them aren't linux drvier but for bareboard. How can I compile them =
using eldk?

You do it exactly the same way like you do it with any other compiler =
toolchain.

If the tools come with Makefiles and Linker scripts for GNU  gcc  and ld =
 then  you are set. If not, you will have to come up with your own build =
rules and linker commands.

You can check how U-Boot code (especially  the  standalone  programs) =
gets  linked, but be warned, this is not exactly trivial. You have to =
understand what you are doing, and how the linker works.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de =
Just because your doctor has a name for your condition  doesn't  mean he =
knows what it is.


------------------------------

Message: 5
Date: Fri, 06 Jan 2006 11:13:25 +0100
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Help need: Porting Linux to PQ2FADS_ZU board=20
To: zengshuai@sogou.com
Cc: ppc <linuxppc-embedded@ozlabs.org>
Message-ID: <20060106101325.B9FED354113@atlas.denx.de>
Content-Type: text/plain; charset=3DISO-8859-1

In message <23894955.1136537390660.JavaMail.postfix@mx3.mail.sohu.com> =
you wrote:
>
> My board is PQ2FADS_ZU.Does the ELDK not support it?

ELDK is, as the  name  suggests,  a  Development  Toolkit,  i.  e.  a
toolchain. As such, it is independent from the hardware and doesn not
support  any specific board, or, if you like, it supports all boards,
even those that don't exist yet.

What you are asking for is board support in a specific  kernel  tree.
There  is  no  specific  support  for  the  PQ2FADS_ZU  board  in our
linuxppc_2_4_devel  tree   (which   is   included   with   the   ELDK
distribution). On the other hand this is a standard board which which
is probably working fine, but we never tested or varified it.

I guess that it is not configured for use with U-Boot.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Never give in.  Never give in.  Never. Never. Never."
- Winston Churchill


------------------------------

Message: 6
Date: Fri, 6 Jan 2006 16:13:42 +0530
From: batsayan.das@tcs.com
Subject: Help on LXT971 eth initialization
To: linuxppc-embedded@ozlabs.org
Message-ID:
	<OFE75E4E98.D56217BF-ON652570EE.0039B69D-652570EE.003AEEB0@tcs.com>
Content-Type: text/plain; charset=3D"us-ascii"


Hi,

My MPC8260 customs board has LXT971 Ethernet chip on FCC1. I am able to=20
get the linux prompt, but I am unable to initialize ethernet. I have =
tried=20
different bootarg options (like setenv bootargs ip=3Ddhcp etc)  and=20
different kernel compilation options (like from make menuconfig, Network =

Option->enable DHCP support etc), but none enables the ethernet =
interface.=20


Any help will be appreciated.

FYI, the ethernet is working from U-Boot.=20

Thanks,
Batsayan Das
Tata Consultancy Services Limited
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or =
attachments to it may contain confidential or privileged information.   =
If you are not the intended recipient, any dissemination, use, review, =
distribution, printing or copying of the information contained in this =
e-mail message and/or attachments to it are strictly prohibited.   If =
you have received this communication in error, please notify us by reply =
e-mail or telephone and immediately and permanently delete the message =
and any attachments.  Thank you
-------------- next part --------------
An HTML attachment was scrubbed...
URL: =
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20060106/83e47b=
9d/attachment-0001.htm

------------------------------

Message: 7
Date: Fri, 6 Jan 2006 12:03:55 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: io.h question
To: linuxppc-embedded@ozlabs.org
Message-ID: <200601061203.55926.arnd@arndb.de>
Content-Type: text/plain;  charset=3D"iso-8859-1"

On Thursday 05 January 2006 21:00, mcnernbm@notes.udayton.edu wrote:
> I finally noticed out_8 and in_8 and what not are located in the
> ppc io.h file in the kernel development download.=A0 But when I=20
> tried to do a io.h with in my program I added #include <asm/io.h>=A0
> and it seems to find it with not problems but it can not find the
> functions with in that file.=A0 Am i missing a define I need to set
> or something so I can see the right files with in io.h I am
> compiling for a ppc405 on a xilinx virtex 4 board.     =20

The definitions in that file are only usable from inside the kernel,
you can not use them in a user space application.

The correct way to solve your problem (which you did not explain, so
I can only guess) would be to write a kernel device driver for
the peripherial you want to drive, at least if it does not exist yet.

For prototyping, you can play with mmap() on /dev/mem in a user
application, but that is often not very reliable.

	Arnd <><


------------------------------

Message: 8
Date: Fri, 6 Jan 2006 18:43:08 +0530
From: batsayan.das@tcs.com
Subject: How to enable PHY
To: linuxppc-embedded@ozlabs.org
Message-ID:
	<OF114C07C5.7CED9F64-ON652570EE.00481B82-652570EE.00489CCF@tcs.com>
Content-Type: text/plain; charset=3D"us-ascii"


Hi,

I found that ADS8260 board enables PHY by the following lines of code

#ifndef CONFIG_ADS8260
        /* Enable the PHY.
        */
        *(volatile uint *)(BCSR_ADDR + 4) &=3D ~BCSR1_FETHIEN;
        *(volatile uint *)(BCSR_ADDR + 4) |=3D  BCSR1_FETH_RST;
#endif


Our board does not have BCSR. My question is how to enable PHY for =
MPC8260=20
based customs board without BCSR?=20

Thanks,
Batsayan Das
Tata Consultancy Services Limited
Mailto: batsayan.das@tcs.com
Website: http://www.tcs.com

Notice: The information contained in this e-mail message and/or =
attachments to it may contain confidential or privileged information.   =
If you are not the intended recipient, any dissemination, use, review, =
distribution, printing or copying of the information contained in this =
e-mail message and/or attachments to it are strictly prohibited.   If =
you have received this communication in error, please notify us by reply =
e-mail or telephone and immediately and permanently delete the message =
and any attachments.  Thank you
-------------- next part --------------
An HTML attachment was scrubbed...
URL: =
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20060106/8701df=
92/attachment-0001.htm

------------------------------

Message: 9
Date: Fri, 6 Jan 2006 08:41:41 -0500
From: "Mark Chambers" <markc@mail.com>
Subject: Re: How to enable PHY
To: <linuxppc-embedded@ozlabs.org>,	<batsayan.das@tcs.com>
Message-ID: <004201c612c6$ee3ede80$6601a8c0@chuck2>
Content-Type: text/plain; charset=3D"iso-8859-1"


>I found that ADS8260 board enables PHY by the following lines of code=20
>
>#ifndef CONFIG_ADS8260=20
>        /* Enable the PHY.=20
>        */=20
>        *(volatile uint *)(BCSR_ADDR + 4) &=3D ~BCSR1_FETHIEN;=20
>        *(volatile uint *)(BCSR_ADDR + 4) |=3D  BCSR1_FETH_RST;=20
>#endif=20
>
>Our board does not have BCSR. My question is how to enable PHY for =
MPC8260 based customs board without BCSR?=20

If your board does not have the BCSR you can just leave this code out.  =
Usually, you only need to configure which MDII=20
interface your PHY is connected to and which IRQ it uses.  But of course =
I don't know how your PHY is wired up on your
custom board.

Mark Chambers


-------------- next part --------------
An HTML attachment was scrubbed...
URL: =
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20060106/9228b0=
02/attachment.htm

------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 17, Issue 11
*************************************************
