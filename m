Return-Path: <dcogley@uslinc.com>
Received: from mtai04.charter.net (mtai04.charter.net [209.225.8.184])
	by ozlabs.org (Postfix) with ESMTP id A72EADE2C0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 04:47:12 +1100 (EST)
Received: from aarprv04.charter.net ([10.20.200.74]) by mtai04.charter.net
	(InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
	id <20071030174705.ESPT12338.mtai04.charter.net@aarprv04.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Oct 2007 13:47:05 -0400
Received: from DCOGLEYNEW ([71.93.35.174]) by aarprv04.charter.net with ESMTP
	id <20071030174700.BKYU23773.aarprv04.charter.net@DCOGLEYNEW>
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Oct 2007 13:47:00 -0400
From: "Dave Cogley" <dcogley@uslinc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Socket I/O in Kernel
Date: Tue, 30 Oct 2007 10:46:49 -0700
Message-ID: <000f01c81b1c$dc2f49e0$2001a8c0@DCOGLEYNEW>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0010_01C81AE2.2FD071E0"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C81AE2.2FD071E0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_001_0011_01C81AE2.2FD2E2E0"


------=_NextPart_001_0011_01C81AE2.2FD2E2E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

I am trying to setup a socket endpoint for network I/O (UDP) into my driver
and I am having some trouble.  I am seemingly able to create and bind a UDP
socket using sock_create_kern without any failure.  The problem comes when I
try to send data over the datagram it always fails with EINVAL.  Is
kernel_sendmsg a valid routine for sending data over unconnected datagrams?
Should I be using kernel_sendpage?  Am I initializing the datagram
correctly?  Is there any working example of how to use UDB sockets at the
kernel level?  I have attached the driver source if you wish to see the
initialization and write routines.  Thank you for your time.

 

Thanks,

Dave Cogley

Software Engineer

Ultra Stereo Labs, Inc.

(805) 549-0161

mailto:dcogley@uslinc.com

 


------=_NextPart_001_0011_01C81AE2.2FD2E2E0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am trying to setup a socket endpoint for network =
I/O (UDP)
into my driver and I am having some trouble.&nbsp; I am seemingly able =
to
create and bind a UDP socket using sock_create_kern without any =
failure.&nbsp; The
problem comes when I try to send data over the datagram it always fails =
with EINVAL.&nbsp;
Is kernel_sendmsg a valid routine for sending data over unconnected
datagrams?&nbsp; Should I be using kernel_sendpage?&nbsp; Am I =
initializing the
datagram correctly?&nbsp; Is there any working example of how to use UDB
sockets at the kernel level?&nbsp; I have attached the driver source if =
you
wish to see the initialization and write routines.&nbsp; Thank you for =
your
time.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dave Cogley<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Software Engineer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ultra Stereo Labs, Inc.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(805) 549-0161<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"mailto:dcogley@uslinc.com">mailto:dcogley@uslinc.com</a></span></=
font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_001_0011_01C81AE2.2FD2E2E0--

------=_NextPart_000_0010_01C81AE2.2FD071E0
Content-Type: text/plain;
	name="banjodecoder.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="banjodecoder.c"

/*=0A=
 * banjodecoder.c=0A=
 * USL, Inc.=0A=
 *=0A=
 * This file contains the driver for the Banjo image and audio decoders.=0A=
 *=0A=
 * Revision 0.1 07/18/2007 dcogley=0A=
 * 	- Initial Creation=0A=
 *=0A=
 */=0A=
=0A=
#include <linux/module.h>=0A=
#include <linux/moduleparam.h>=0A=
#include <linux/init.h>=0A=
#include <linux/kernel.h>=0A=
#include <linux/slab.h>=0A=
#include <linux/fs.h>=0A=
#include <linux/errno.h>=0A=
#include <linux/types.h>=0A=
#include <linux/proc_fs.h>=0A=
#include <linux/interrupt.h>=0A=
#include <linux/delay.h>=0A=
#include <linux/ctype.h>=0A=
#include <linux/net.h>=0A=
#include <linux/socket.h>=0A=
#include <linux/in.h>=0A=
#include <linux/udp.h>=0A=
=0A=
#include <asm/io.h>=0A=
#include <asm/uaccess.h>=0A=
=0A=
#include "banjodecoder.h"=0A=
=0A=
#define DRIVER_VERSION	"0.1"=0A=
#define DRIVER_NAME		"banjodecoder"=0A=
=0A=
MODULE_DESCRIPTION("USL, Inc. Image Decoder driver v" DRIVER_VERSION);=0A=
MODULE_LICENSE("GPL");=0A=
MODULE_AUTHOR("Dave Cogley");=0A=
=0A=
int banjo_major =3D BANJO_MAJOR;=0A=
module_param(banjo_major, int, 0);=0A=
=0A=
struct banjo_dev* banjo_device =3D 0;=0A=
void __iomem* banjo_regmap =3D 0;=0A=
void __iomem* gpio1_or =3D 0;=0A=
=0A=
// the data port socket descriptor=0A=
static struct udp_sock* sockData =3D 0;=0A=
struct sockaddr_in sinDataAddr =3D { 0 };=0A=
=0A=
// the control port socket descriptor=0A=
static struct udp_sock* sockControl =3D 0;=0A=
struct sockaddr_in sinControlAddr =3D { 0 };=0A=
=0A=
// the transmit buffer=0A=
volatile static char sockBuf[MAX_TX_PACKET + PKTALIGN];=0A=
volatile static char* sockTxBuf;=0A=
=0A=
extern int banjosock_init(const char* serverip);=0A=
extern void banjosock_cleanup(void);=0A=
extern int banjosock_decueFeature(void);=0A=
extern int banjosock_cueFeature(const char* feature);=0A=
extern int banjosock_requestFrame(int frame);=0A=
=0A=
/* Macros for accessing the indirect EBC registers */=0A=
void mtebc(u32 reg, u32 data)=0A=
{=0A=
	mtdcr(ebccfga, reg);=0A=
	mtdcr(ebccfgd, data);=0A=
}=0A=
=0A=
u32 mfebc(u32 reg)=0A=
{=0A=
	mtdcr(ebccfga, reg);=0A=
	return mfdcr(ebccfgd);=0A=
}=0A=
=0A=
void enable_per_ready(int enable)=0A=
{=0A=
	u32 pb1ap;=0A=
=0A=
	// set peripheral 1 access permissions to disable "peripheral ready"=0A=
	pb1ap =3D mfebc(PB1AP);=0A=
	if (enable)=0A=
		pb1ap |=3D PB1AP_ENABLE;=0A=
	else=0A=
		pb1ap &=3D ~PB1AP_ENABLE;=0A=
	mtebc(PB1AP, pb1ap);=0A=
}=0A=
=0A=
static void setup_dma_buffer(void)=0A=
{=0A=
	// setup count and control register=0A=
	mtdcr(DMA2P40_CTC0, DMA_CONTROLTC0);=0A=
=0A=
	// 64b source address=0A=
	mtdcr(DMA2P40_SAH0, 0x00000000);	// must be zero=0A=
	mtdcr(DMA2P40_SAL0, DMABUFFERBASE);=0A=
	=0A=
	// destination address is fixed to the banjo decoder media address=0A=
	// the destination address really does not matter to the FPGA but=0A=
	// because of address alignment problems we want to start at the=0A=
	// base address=0A=
	mtdcr(DMA2P40_DAH0, 0x00000001);	// destination is addressable on the =
EBC=0A=
	mtdcr(DMA2P40_DAL0, BANJO_DECODER_BASE);=0A=
}=0A=
=0A=
irqreturn_t dma_status_int(int irq, void *dev_id, struct pt_regs *regs)=0A=
{=0A=
	u32 status;=0A=
=0A=
	// get and clear the DMA status=0A=
	status =3D mfdcr(DMA2P40_SR);=0A=
	mtdcr(DMA2P40_SR, status);=0A=
=0A=
	// status is TC expire, EOT request (never happens) or error occured=0A=
	if (status & DMA0_TC_REACHED ||=0A=
		status & DMA0_EOT_REQ ||=0A=
		status & DMA0_ERROR)=0A=
	{=0A=
		if (status & DMA0_ERROR)=0A=
		{=0A=
			// frame xfer asseterted a DMA error=0A=
			banjo_device->frames_dma_error++;=0A=
		}=0A=
		else=0A=
		{=0A=
			// frame successfully transfered=0A=
			banjo_device->frames_sent++;=0A=
		}=0A=
=0A=
		// drive GPIO48 (EOTn) high to indicate end of transfer =0A=
		writel(EOTN_DRIVE_HIGH, gpio1_or);=0A=
=0A=
		// release the DMA buffer=0A=
		banjo_device->dma.flags =3D 0;=0A=
	}=0A=
=0A=
	return IRQ_HANDLED;=0A=
}=0A=
=0A=
irqreturn_t frame_req_int(int irq, void *dev_id, struct pt_regs *regs)=0A=
{=0A=
	u32 control;=0A=
=0A=
	// increment frames requested=0A=
	banjo_device->frames_request++;=0A=
=0A=
	// is buffer available?=0A=
	if (!(banjo_device->dma.flags & BANJO_DMA_FLAG_DMAREADY))=0A=
	{=0A=
		banjo_device->frames_not_ready++;=0A=
		return IRQ_HANDLED;	// frame request made and buffer was not ready!=0A=
	}=0A=
=0A=
	setup_dma_buffer();=0A=
	=0A=
	// drive GPIO48 (EOTn) low=0A=
	writel(EOTN_DRIVE_LOW, gpio1_or);=0A=
=0A=
	// enable the DMA channel=0A=
	// the DMA channel is now armed and will begin the transfer immediatly=0A=
	// to the configured DMA addresses=0A=
	control =3D mfdcr(DMA2P40_CR0);=0A=
	control |=3D DMA_ENABLE_CHANNEL;=0A=
	mtdcr(DMA2P40_CR0, control);=0A=
=0A=
	return IRQ_HANDLED;=0A=
}=0A=
=0A=
int banjo_open(struct inode* inode, struct file* filp)=0A=
{=0A=
	return 0;=0A=
}=0A=
=0A=
int banjo_release(struct inode* inode, struct file* filp)=0A=
{=0A=
	return 0;=0A=
}=0A=
=0A=
int banjo_ioctl(struct inode* inode, struct file* filp, unsigned int =
cmd, unsigned long arg)=0A=
{=0A=
	int ret =3D 0;=0A=
	u32 status;=0A=
	u32 frame;=0A=
=0A=
	switch (cmd)=0A=
	{=0A=
		// reset the banjo decoder=0A=
		case BANJO_IOCDECODERRESET:=0A=
			writel(0xffffffff, banjo_regmap + BANJO_RESET_ADDR);=0A=
			writel(0x00000000, banjo_regmap + BANJO_RESET_ADDR);=0A=
			mdelay(BANJO_RESET_DELAY);=0A=
		break;=0A=
		case BANJO_IOCDECODERSTATUS:=0A=
=0A=
			// peripheral ready must be enabled while reading resigeter map=0A=
			enable_per_ready(1);=0A=
=0A=
			status =3D readl(banjo_regmap + BANJO_STATUS_ADDR);=0A=
			ret =3D __put_user(status, (long __user*)arg);=0A=
=0A=
			enable_per_ready(0);=0A=
=0A=
		break;=0A=
		case BANJO_IOCENABLESTREAM:=0A=
			// enable the frame request interrupts=0A=
			writel(0xffffffff, banjo_regmap + BANJO_STATUS_ADDR);=0A=
		break;=0A=
		case BANJO_IOCCONNECTSERVER:=0A=
			// initialize network layer=0A=
//			banjosock_init("128.0.0.1\0");=0A=
			banjosock_init("192.168.1.49\0");=0A=
		break;=0A=
		case BANJO_IOCDISCONNECTSERVER:=0A=
			banjosock_cleanup();=0A=
		break;=0A=
		case BANJO_IOCCUEFEATURE:=0A=
			// decue current feature=0A=
			banjosock_cueFeature("urn:uuid:a36c264b-2926-fc46-8e10-93e24a75d1c0");=0A=
		break;=0A=
		case BANJO_IOCDECUEFEATURE:=0A=
			// decue current feature=0A=
			banjosock_decueFeature();=0A=
		break;=0A=
		case BANJO_IOCREQUESTFRAME:=0A=
			// get the frame we want to request=0A=
			__get_user(frame, (long __user*)arg);=0A=
=0A=
			// make a frame request and pass the current DMA frame buffer=0A=
			banjosock_requestFrame(frame);=0A=
			banjo_device->dma.flags |=3D BANJO_DMA_FLAG_DMAREADY;=0A=
		break;=0A=
	}=0A=
=0A=
	return ret;=0A=
}=0A=
=0A=
static inline int do_sendto(struct socket* sock, struct kvec* vec, int =
count, =0A=
	int len, unsigned flags, struct sockaddr_in* sin)=0A=
{=0A=
	struct msghdr msg;=0A=
=0A=
	msg.msg_name =3D sin;=0A=
	msg.msg_namelen =3D sizeof (struct sockaddr_in);=0A=
	msg.msg_flags =3D flags;=0A=
=0A=
	return kernel_sendmsg(sock, &msg, vec, count, len);=0A=
}=0A=
=0A=
static int _sendto(struct socket* sock, const void *buf, int len, =0A=
	struct sockaddr_in* sin)=0A=
{=0A=
	struct kvec vec;=0A=
	vec.iov_base =3D (void*)buf;=0A=
	vec.iov_len =3D len;=0A=
=0A=
	return do_sendto(sock, &vec, 1, len, 0, sin);=0A=
}=0A=
=0A=
static int _recv(struct socket *sock, void* buf, int size, unsigned =
flags)=0A=
{=0A=
	struct msghdr msg =3D { NULL, };=0A=
	struct kvec iov =3D { buf, size };=0A=
	return kernel_recvmsg(sock, &msg, &iov, 1, size, flags);=0A=
}=0A=
=0A=
int banjosock_inetaddr(const char* cp, u32* dst)=0A=
{=0A=
	int value;=0A=
	int digit;=0A=
	int i;=0A=
	char temp;=0A=
	char bytes[4] =3D { 0 };=0A=
	char *end =3D bytes;=0A=
	static const int addr_class_max[4] =3D=0A=
	    { 0xffffffff, 0xffffff, 0xffff, 0xff };=0A=
=0A=
	temp =3D *cp;=0A=
=0A=
	while (1) =0A=
	{=0A=
		if (!isdigit(temp))=0A=
			return 0;=0A=
=0A=
		value =3D 0;=0A=
		digit =3D 0;=0A=
		for (;;) =0A=
		{=0A=
			if (isascii(temp) && isdigit(temp)) =0A=
			{=0A=
				value =3D (value * 10) + temp - '0';=0A=
				temp =3D *++cp;=0A=
				digit =3D 1;=0A=
			} else=0A=
				break;=0A=
		}=0A=
=0A=
		if (temp =3D=3D '.') =0A=
		{=0A=
			if ((end > bytes + 2) || (value > 255))=0A=
				return 0;=0A=
			*end++ =3D value;=0A=
			temp =3D *++cp;=0A=
		}=0A=
		else=0A=
			break;=0A=
	}=0A=
=0A=
	if (value > addr_class_max[end - bytes])=0A=
		return 0;=0A=
=0A=
	*((u32*)dst) =3D *((u32*)bytes) | htonl(value);=0A=
=0A=
	return 1; /* success */=0A=
}=0A=
=0A=
// initialize our socket i/o=0A=
int banjosock_init(const char* serverip)=0A=
{=0A=
	// setup data and control addresses=0A=
	sinDataAddr.sin_family =3D AF_INET;=0A=
	sinDataAddr.sin_port =3D htons(DATAPORT);=0A=
	banjosock_inetaddr(serverip, &sinDataAddr.sin_addr.s_addr);=0A=
=0A=
	sinControlAddr.sin_family =3D AF_INET;=0A=
	sinControlAddr.sin_port =3D htons(CONTROLPORT);=0A=
	banjosock_inetaddr(serverip, &sinControlAddr.sin_addr.s_addr);=0A=
=0A=
	// allocate a data stream descriptor=0A=
	if (sock_create_kern(PF_INET, SOCK_DGRAM, IPPROTO_UDP, &sockData) < 0 =
|| =0A=
			!sockData ||=0A=
		kernel_connect(sockData, sinDataAddr, sizeof (sinDataAddr)) < 0)=0A=
	{=0A=
		printk(KERN_ERR "banjosock_init: problem creating / binding DATA =
socket\n");=0A=
		return -1;=0A=
	}=0A=
=0A=
	// allocate a control port descriptor=0A=
	if (sock_create_kern(AF_INET, SOCK_DGRAM, IPPROTO_UDP, &sockControl) < =
0 || =0A=
			!sockControl ||=0A=
		kernel_connect(sockControl, sinControlAddr, sizeof (sinControlAddr)) < =
0)=0A=
=0A=
	{=0A=
		printk(KERN_ERR "banjosock_init: problem creating / binding CONTROL =
socket\n");=0A=
		return -1;=0A=
	}=0A=
=0A=
	// align the tx buffer in memory=0A=
	sockTxBuf =3D &sockBuf[0] + (PKTALIGN - 1);=0A=
	sockTxBuf -=3D (u32)sockTxBuf % PKTALIGN;=0A=
	=0A=
	return 0;=0A=
}=0A=
=0A=
void banjosock_cleanup(void)=0A=
{=0A=
	if (sockData)=0A=
		sock_release(sockData);=0A=
	if (sockControl)=0A=
		sock_release(sockControl);=0A=
}=0A=
=0A=
static int banjosock_sendmesg(u32 type, u32 size, u32 param, u32 =
reserved)=0A=
{=0A=
	// append a header and send it to the server=0A=
	struct Header* h =3D (struct Header*)&sockTxBuf;=0A=
	h->type =3D htonl(type);=0A=
	h->size =3D htonl(size);=0A=
	h->parameter =3D htonl(param);=0A=
	h->reserved =3D htonl(reserved);=0A=
=0A=
	return _sendto(sockData, (void*)sockTxBuf, size + sizeof (struct =
Header), =0A=
		(struct sockaddr_in*)&sinDataAddr);=0A=
}=0A=
=0A=
static int banjosock_sendwindow(u32 window)=0A=
{=0A=
	// send the next window request to the server via the control port=0A=
	u32* l =3D (u32*)&sockTxBuf;=0A=
	*l =3D htonl(window);=0A=
	return _sendto(sockData, (void*)sockTxBuf, sizeof (u32), =0A=
		(struct sockaddr_in*)&sinControlAddr);=0A=
}=0A=
=0A=
int banjosock_handledata(void)=0A=
{=0A=
	int ret =3D 0;=0A=
	u32 recv, total;=0A=
	char hdrbuf[sizeof (struct Header)];=0A=
	struct Header* h =3D (struct Header*)&hdrbuf;=0A=
=0A=
	// get the header coming down the line=0A=
	ret =3D _recv(sockData, hdrbuf, sizeof (struct Header), 0);=0A=
	if (ret < 0)=0A=
	{=0A=
		printk(KERN_ERR "banjosock_handledata: failed to receive data from =
socket (%d)\n", ret);=0A=
		return -1;=0A=
	}=0A=
=0A=
	// convert to host=0A=
	h->type =3D htonl(h->type);=0A=
	h->size =3D htonl(h->size);=0A=
	h->parameter =3D htonl(h->parameter);=0A=
	h->reserved =3D htonl(h->reserved);=0A=
=0A=
	switch (h->type)=0A=
	{=0A=
		case ACK:=0A=
		break;=0A=
		case NAK:=0A=
		break;=0A=
		case EOT:=0A=
		break;=0A=
		case VIDEO_FRAME:=0A=
	=0A=
			// get the data still remaining in queue=0A=
			recv =3D 0;=0A=
			total =3D h->size;=0A=
			while (recv < total)=0A=
			{=0A=
				ret =3D _recv(sockData, (void*)(banjo_device->dma.buf + recv), total =
- recv, 0);=0A=
				recv +=3D ret;=0A=
				// request more data at window intervals=0A=
				if (recv < total && (recv % WINDOWSIZE) =3D=3D 0)=0A=
				{=0A=
					ret =3D banjosock_sendwindow(WINDOWSIZE);=0A=
					if (ret < 0)=0A=
					{=0A=
						printk(KERN_ERR "banjosock_handledata: failed to send window msg =
(%d)\n", ret);=0A=
						return -1;=0A=
					}=0A=
				}=0A=
			}=0A=
		break;=0A=
	}=0A=
=0A=
	return ret;=0A=
}=0A=
=0A=
int banjosock_decueFeature(void)=0A=
{=0A=
	int ret;=0A=
=0A=
	// de-cue the current feature=0A=
	ret =3D banjosock_sendmesg(DECUE_FEATURE, 0, 0, 0);=0A=
	if (ret < 0)=0A=
	{=0A=
		printk(KERN_ERR "banjosock_decueFeature: failed to send de-cue msg =
(%d)\n", ret);=0A=
		return -1;=0A=
	}=0A=
	return banjosock_handledata();=0A=
}=0A=
=0A=
int banjosock_cueFeature(const char* feature)=0A=
{=0A=
	int ret;=0A=
=0A=
	// assemble the tx packet=0A=
	char* pkt =3D (char*)sockTxBuf;=0A=
	pkt +=3D sizeof (struct Header);=0A=
	strcpy(pkt, feature);=0A=
=0A=
	// cue the requested feature=0A=
	ret =3D banjosock_sendmesg(CUE_FEATURE, strlen(feature), 0, 0);=0A=
	if (ret < 0)=0A=
	{=0A=
		printk(KERN_ERR "banjosock_cueFeature: failed to send cue feature msg =
(%d)\n", ret);=0A=
		return -1;=0A=
	}=0A=
=0A=
	return banjosock_handledata();=0A=
}=0A=
=0A=
int banjosock_requestFrame(int frame)=0A=
{=0A=
	int ret;=0A=
=0A=
	// cue the requested feature=0A=
	ret =3D banjosock_sendmesg(VIDEO_FRAME_REQUEST, 0, frame, WINDOWSIZE);=0A=
	if (ret < 0)=0A=
	{=0A=
		printk(KERN_ERR "banjosock_requestFrame: failed to send request frame =
msg (%d)\n", ret);=0A=
		return -1;=0A=
	}=0A=
=0A=
	return banjosock_handledata();=0A=
}=0A=
=0A=
int banjo_dmastatus_proc(char* buf, char** start, off_t offset, int =
count, int* eof, void* data)=0A=
{=0A=
	int len =3D 0;=0A=
=0A=
	len +=3D sprintf(buf + len, "\nBanjo Decoder - DMA");=0A=
	len +=3D sprintf(buf + len, "\n\tDCRN_DMASR\t: %08X", =
mfdcr(DMA2P40_SR));=0A=
	len +=3D sprintf(buf + len, "\n\trequests\t: %d", =
banjo_device->frames_request);=0A=
	len +=3D sprintf(buf + len, "\n\tframes sent\t: %d", =
banjo_device->frames_sent);=0A=
	len +=3D sprintf(buf + len, "\n\tnot ready\t: %d", =
banjo_device->frames_not_ready);=0A=
	len +=3D sprintf(buf + len, "\n\tdma error\t: %d", =
banjo_device->frames_dma_error);=0A=
	len +=3D sprintf(buf + len, "\n\n");=0A=
	=0A=
	*eof =3D 1;=0A=
	return len;=0A=
}=0A=
=0A=
struct file_operations banjo_fops =3D =0A=
{=0A=
	.owner =3D     THIS_MODULE,=0A=
	.llseek =3D    0,=0A=
	.read =3D	     0,=0A=
	.write =3D     0,=0A=
	.ioctl =3D     banjo_ioctl,=0A=
	.open =3D	     banjo_open,=0A=
	.release =3D   banjo_release,=0A=
};=0A=
=0A=
static void banjo_setup_cdev(struct banjo_dev* dev, int index)=0A=
{=0A=
	int devno =3D MKDEV(banjo_major, index);=0A=
    =0A=
	cdev_init(&dev->cdev, &banjo_fops);=0A=
=0A=
	dev->cdev.owner =3D THIS_MODULE;=0A=
	dev->cdev.ops =3D &banjo_fops;=0A=
	cdev_add(&dev->cdev, devno, 1);=0A=
}=0A=
=0A=
static void __init dma_init(void)=0A=
{=0A=
	// setup the channel 0 control register=0A=
	mtdcr(DMA2P40_CR0, DMA_CONFIG0);=0A=
=0A=
	// remap DMA buffer=0A=
	banjo_device->dma.buf =3D ioremap(DMABUFFERBASE, DMABUFFERSIZE);=0A=
	banjo_device->dma.flags =3D 0;=0A=
=0A=
	enable_per_ready(0);=0A=
}=0A=
=0A=
static void __init init_interrupts(void)=0A=
{=0A=
	// map interrupt handler for DMA status=0A=
	request_irq(DMA_STATUS_IRQ, dma_status_int, SA_INTERRUPT, =0A=
		DRIVER_NAME, dma_status_int);=0A=
	=0A=
	// map interrupt handler for frame ready interrupt IRQ7=0A=
	request_irq(FRAME_READY_IRQ, frame_req_int, SA_INTERRUPT, =0A=
		DRIVER_NAME, frame_req_int);=0A=
}=0A=
=0A=
static int __init banjo_init(void)=0A=
{=0A=
	int result;=0A=
	dev_t dev =3D MKDEV(banjo_major, 0);=0A=
=0A=
	printk(KERN_INFO "USL, Inc. Image Decoder driver v" DRIVER_VERSION =
"\n");=0A=
=0A=
	/*=0A=
	 * Register your major, and accept a dynamic number.=0A=
	 */=0A=
	if (banjo_major)=0A=
		result =3D register_chrdev_region(dev, 0, DRIVER_NAME);=0A=
	else =0A=
	{=0A=
		result =3D alloc_chrdev_region(&dev, 0, 0, DRIVER_NAME);=0A=
		banjo_major =3D MAJOR(dev);=0A=
	}=0A=
	if (result < 0)=0A=
		return result;=0A=
=0A=
	// remap the FPGA registers=0A=
	banjo_regmap =3D ioremap(BANJO_DECODER_BASE, BANJO_REGISTERMAP_SIZE);=0A=
=0A=
	// remap GPIO1 port address=0A=
	gpio1_or =3D ioremap(GPIO1_OR, sizeof (long));=0A=
	=0A=
	// allocate all device structures=0A=
	banjo_device =3D kmalloc(sizeof (struct banjo_dev), GFP_KERNEL);=0A=
	memset(banjo_device, 0, sizeof (struct banjo_dev));=0A=
=0A=
	// register character devices with the kernel=0A=
	banjo_setup_cdev(banjo_device, 0);=0A=
=0A=
	// create /proc fs entries=0A=
	create_proc_read_entry("banjodma", 0, NULL, banjo_dmastatus_proc, NULL);=0A=
=0A=
	// initialize DMA=0A=
	dma_init();=0A=
=0A=
	// initialize interrupts=0A=
	init_interrupts();=0A=
=0A=
	return 0;=0A=
}=0A=
=0A=
static void __exit banjo_exit(void)=0A=
{=0A=
	free_irq(FRAME_READY_IRQ, NULL);=0A=
	free_irq(DMA_STATUS_IRQ, NULL);=0A=
=0A=
	banjosock_cleanup();=0A=
=0A=
	cdev_del(&banjo_device->cdev);=0A=
	kfree(banjo_device);=0A=
=0A=
	remove_proc_entry("banjodma", NULL);=0A=
=0A=
	iounmap(gpio1_or);=0A=
	iounmap(banjo_regmap);=0A=
	iounmap(banjo_device->dma.buf);=0A=
=0A=
	unregister_chrdev_region(MKDEV(banjo_major, 0), 1);=0A=
}=0A=
=0A=
module_init(banjo_init);=0A=
module_exit(banjo_exit);=0A=

------=_NextPart_000_0010_01C81AE2.2FD071E0--
