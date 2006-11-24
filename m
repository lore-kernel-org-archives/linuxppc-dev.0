Return-Path: <mjoshi_blr@yahoo.com>
Received: from web34715.mail.mud.yahoo.com (web34715.mail.mud.yahoo.com
	[209.191.68.164]) by ozlabs.org (Postfix) with SMTP id 5982067B77
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Nov 2006 04:24:56 +1100 (EST)
Message-ID: <20061124171814.56700.qmail@web34715.mail.mud.yahoo.com>
Date: Fri, 24 Nov 2006 09:18:14 -0800 (PST)
From: Manish Joshi <mjoshi_blr@yahoo.com>
Subject: Re: virt_to_bus and DMA
To: Ilse Reyneke <reynekejunk@hotmail.com>, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2089694040-1164388694=:56225"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2089694040-1164388694=:56225
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

you can use __pa() along with kmalloc(..., GFP_KERNEL | GFP_DMA).=0A=0A=0A=
=0A----- Original Message ----=0AFrom: Ilse Reyneke <reynekejunk@hotmail.co=
m>=0ATo: linuxppc-embedded@ozlabs.org=0ASent: Friday, November 24, 2006 9:0=
7:58 PM=0ASubject: virt_to_bus and DMA=0A=0A=0AHi there,=0A=0AQuestion from=
 a relative newby.=0A=0ACan someone please tell me how to get the bus/physi=
cal address from a =0Avirtual address? To familiarise myself with the PPC4x=
x DMA API I'm trying to =0Aget a simple mem-mem DMA working (any good sampl=
es out there??). The =0Afollowing code snippet seems to be the way of alloc=
ating memory buffers for =0Athe transfer:=0A=0A  int size =3D 2*1024;=0A  u=
int32_t* sourceaddr =3D (uint32_t *)__get_free_pages(GFP_KERNEL =0A|GFP_DMA=
,get_order(size));=0A  uint32_t* destaddr =3D (uint32_t *)__get_free_pages(=
GFP_KERNEL |GFP_DMA,=0Aget_order(size));=0A=0A  phys_addr_t physdest =3D vi=
rt_to_bus((u32 *)destaddr);=0A  phys_addr_t physsource =3D virt_to_bus((u32=
 *)sourceaddr);=0A=0A=0AThe problem is that virt_to_bus seems to be returni=
ng 0. I understand that =0Ait is generally undesirable to use the deprecate=
d virt_to_bus, but what are =0Athe alternatives?=0A=0AAm I also correct in =
saying the "standard DMA API" (request_dma, =0Aset_dma_addr etc) is NOT ava=
ilable on the 4xx?=0A=0AWe're making use of the 440EPx, Linux 2.6.14 kernel=
.=0A=0ACheers=0A   Jan Reyneke=0A=0A_______________________________________=
__________________________=0AWindows Live=99 Messenger has arrived. Click h=
ere to download it for free! =0Ahttp://imagine-msn.com/messenger/launch80/?=
locale=3Den-gb=0A_______________________________________________=0ALinuxppc=
-embedded mailing list=0ALinuxppc-embedded@ozlabs.org=0Ahttps://ozlabs.org/=
mailman/listinfo/linuxppc-embedded=0A=0A=0A =0A____________________________=
________________________________________________________=0ACheap talk?=0ACh=
eck out Yahoo! Messenger's low PC-to-Phone call rates.=0Ahttp://voice.yahoo=
.com
--0-2089694040-1164388694=:56225
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">you can use __pa() along with kmalloc(..., GFP_KE=
RNEL | GFP_DMA).<BR><BR><BR>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: =
times new roman, new york, times, serif">----- Original Message ----<BR>Fro=
m: Ilse Reyneke &lt;reynekejunk@hotmail.com&gt;<BR>To: linuxppc-embedded@oz=
labs.org<BR>Sent: Friday, November 24, 2006 9:07:58 PM<BR>Subject: virt_to_=
bus and DMA<BR><BR>=0A<DIV>Hi there,<BR><BR>Question from a relative newby.=
<BR><BR>Can someone please tell me how to get the bus/physical address from=
 a <BR>virtual address? To familiarise myself with the PPC4xx DMA API I'm t=
rying to <BR>get a simple mem-mem DMA working (any good samples out there??=
). The <BR>following code snippet seems to be the way of allocating memory =
buffers for <BR>the transfer:<BR><BR>&nbsp;&nbsp;int size =3D 2*1024;<BR>&n=
bsp;&nbsp;uint32_t* sourceaddr =3D (uint32_t *)__get_free_pages(GFP_KERNEL =
<BR>|GFP_DMA,get_order(size));<BR>&nbsp;&nbsp;uint32_t* destaddr =3D (uint3=
2_t *)__get_free_pages(GFP_KERNEL |GFP_DMA,<BR>get_order(size));<BR><BR>&nb=
sp;&nbsp;phys_addr_t physdest =3D virt_to_bus((u32 *)destaddr);<BR>&nbsp;&n=
bsp;phys_addr_t physsource =3D virt_to_bus((u32 *)sourceaddr);<BR><BR><BR>T=
he problem is that virt_to_bus seems to be returning 0. I understand that <=
BR>it is generally undesirable to use the deprecated virt_to_bus, but what =
are <BR>the alternatives?<BR><BR>Am I also
 correct in saying the "standard DMA API" (request_dma, <BR>set_dma_addr et=
c) is NOT available on the 4xx?<BR><BR>We're making use of the 440EPx, Linu=
x 2.6.14 kernel.<BR><BR>Cheers<BR>&nbsp;&nbsp; Jan Reyneke<BR><BR>_________=
________________________________________________________<BR>Windows Live=99=
 Messenger has arrived. Click here to download it for free! <BR><A href=3D"=
http://imagine-msn.com/messenger/launch80/?locale=3Den-gb" target=3D_blank>=
http://imagine-msn.com/messenger/launch80/?locale=3Den-gb</A></DIV>=0A<DIV>=
_______________________________________________<BR>Linuxppc-embedded mailin=
g list<BR>Linuxppc-embedded@ozlabs.org<BR><A href=3D"https://ozlabs.org/mai=
lman/listinfo/linuxppc-embedded" target=3D_blank>https://ozlabs.org/mailman=
/listinfo/linuxppc-embedded</A></DIV></DIV><BR></DIV></div><br>=0A=0A<hr si=
ze=3D1>Everyone is raving about <a href=3D"http://us.rd.yahoo.com/evt=3D450=
83/*http://advision.webevents.yahoo.com/mailbeta">the all-new Yahoo! Mail b=
eta.</a></body></html>
--0-2089694040-1164388694=:56225--
