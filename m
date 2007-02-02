Return-Path: <vpd.84@rediffmail.com>
Received: from rediffmail.com (unknown [59.160.240.224])
	by ozlabs.org (Postfix) with SMTP id 6C430DDE2D
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 18:08:01 +1100 (EST)
Date: 2 Feb 2007 06:58:25 -0000
Message-ID: <20070202065825.11166.qmail@webmail99.rediffmail.com>
MIME-Version: 1.0
From: "Vikram Dhir" <vpd.84@rediffmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Multicast problem on MPC8272ADS
Content-type: multipart/alternative;
	boundary="Next_1170399505---0-59.160.240.224-11157"
Reply-To: Vikram Dhir <vpd.84@rediffmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 This is a multipart mime message


--Next_1170399505---0-59.160.240.224-11157
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,=0A=0AI have written a multicast test application in which there is a mu=
lticast sender and receiver. The multicast sender sends multicast packets o=
n a specified interface and the multicast receiver receives multicast packe=
ts. I have tested this application on my network with x86 machines. But whe=
n I run a multicast receiver (which has been cross compiled for MPC8272ADS)=
 on my MPC board, it is unable to receive multicast packets (the recvfrom c=
all is waiting for ever for packets to arrive). The MPC board is able to se=
nd multicast packets to without any problems. The /proc/net/dev_mcast shows=
 the appropriate entries for the multicast address being enabled for the in=
terface of interest(esentially group joining appear to work).=0A=0AMy confi=
guration is a MPC8272ADS board with Linux Kernel 2.6.16.34 and I m using th=
e Freescale Ethernet driver, with ethernet using FCC(with multicast enabled=
). rp_filter =3D0 for all interfaces (ie no source filtering).=0A=0AI am wo=
ndering where the problem could be, configurations or the ethernet driver i=
tself? Are there some known issues with the freescale ethernet driver that =
comes with the Linux Kernel? =0A=0ABy the way with loopback enabled the rec=
eption of packets works in case the sender and receiver are on the same mac=
hine [as expected].=0A=0Avpd=0A
--Next_1170399505---0-59.160.240.224-11157
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0AHi,<BR>=0A<BR>=0AI have written a multicast test application in which=
 there is a multicast sender and receiver. The multicast sender sends multi=
cast packets on a specified interface and the multicast receiver receives m=
ulticast packets. I have tested this application on my network with x86 mac=
hines. But when I run a multicast receiver (which has been cross compiled f=
or MPC8272ADS) on my MPC board, it is unable to receive multicast packets (=
the recvfrom call is waiting for ever for packets to arrive). The MPC board=
 is able to send multicast packets to without any problems. The /proc/net/d=
ev_mcast shows the appropriate entries for the multicast address being enab=
led for the interface of interest(esentially group joining appear to work).=
<BR>=0A<BR>=0AMy configuration is a MPC8272ADS board with Linux Kernel 2.6.=
16.34 and I m using the Freescale Ethernet driver, with ethernet using FCC(=
with multicast enabled). rp_filter =3D0 for all interfaces (ie no source fi=
ltering).<BR>=0A<BR>=0AI am wondering where the problem could be, configura=
tions or the ethernet driver itself? Are there some known issues with the f=
reescale ethernet driver that comes with the Linux Kernel? <BR>=0A<BR>=0ABy=
 the way with loopback enabled the reception of packets works in case the s=
ender and receiver are on the same machine [as expected].<BR>=0A<BR>=0Avpd<=
BR>=0A=0A</P>=0A<br><br>=0A<a href=3D"http://adworks.rediff.com/cgi-bin/AdW=
orks/sigclick.cgi/www.rediff.com/signature-home.htm/1507191490@Middle5?PART=
NER=3D3"><IMG SRC=3D"http://adworks.rediff.com/cgi-bin/AdWorks/sigimpress.c=
gi/www.rediff.com/signature-home.htm/1963059423@Middle5?OAS_query=3Dnull&PA=
RTNER=3D3" BORDER=3D0 VSPACE=3D0 HSPACE=3D0></a>=0A
--Next_1170399505---0-59.160.240.224-11157--
