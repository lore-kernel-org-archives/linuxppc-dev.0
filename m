Return-Path: <jay_chen@alphanetworks.com>
Received: from Sweeper2.alphanetworks.com (sweeper2.alphanetworks.com
	[210.202.42.140]) by ozlabs.org (Postfix) with ESMTP id 669EDDDE24
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Nov 2008 01:32:03 +1100 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: MPC8349 DMA
Date: Tue, 11 Nov 2008 22:16:51 +0800
Message-ID: <0697112B46494D3DB284F1EBA6F65D4E@alphajay>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_011E_01C9444B.34D59BA0"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_011E_01C9444B.34D59BA0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"

Hi,
 
I am using 2.6.14.5 and MPC8349.
I got some DMA problems with PCI devices.
So, I tried to understand the DMA stuff of linux.
 
I have one question about cache coherency.
In dma-mapping.h, I found some functions are defined as NULL.
For example:
#define dma_cache_inv(_start,_size)  do { } while (0)
#define dma_cache_wback(_start,_size)  do { } while (0)
#define dma_cache_wback_inv(_start,_size) do { } while (0)
 
#define __dma_alloc_coherent(gfp, size, handle) NULL
#define __dma_free_coherent(size, addr)  do { } while (0)
#define __dma_sync(addr, size, rw)  do { } while (0)
#define __dma_sync_page(pg, off, sz, rw) do { } while (0)

Does this mean that I don't need to take care of cache coherency in MPC83xx
platform?
So, I could use any range of memory for DMA transferring and the hardware
will take care of the cache coherency for me?
 
Thanks a lot.
 
                                    Jay Chen.
 

------=_NextPart_000_011E_01C9444B.34D59BA0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset="us-ascii"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16735" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D938413313-11112008>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D938413313-11112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>I am using 2.6.14.5=20
and MPC8349.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>I got some DMA=20
problems with PCI devices.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>So,&nbsp;I tried to=20
understand the DMA stuff of linux.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D938413313-11112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>I have one question=20
about cache coherency.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>In dma-mapping.h, I=20
found some functions are defined as NULL.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>For=20
example:</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>#define=20
dma_cache_inv(_start,_size)&nbsp;&nbsp;do { } while (0)<BR>#define=20
dma_cache_wback(_start,_size)&nbsp;&nbsp;do { } while (0)<BR>#define=20
dma_cache_wback_inv(_start,_size)&nbsp;do { } while =
(0)</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>#define=20
__dma_alloc_coherent(gfp, size, handle)&nbsp;NULL<BR>#define=20
__dma_free_coherent(size, addr)&nbsp;&nbsp;do { } while (0)<BR>#define=20
__dma_sync(addr, size, rw)&nbsp;&nbsp;do { } while (0)<BR>#define=20
__dma_sync_page(pg, off, sz, rw)&nbsp;do { } while =
(0)<BR></SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>Does this mean that I=20
don't need to take care of cache coherency in MPC83xx=20
platform?</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>So, I could use any=20
range of memory for DMA transferring and the hardware will take care of =
the=20
cache coherency for me?</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D938413313-11112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN =
class=3D938413313-11112008>Thanks a=20
lot.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D938413313-11112008></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D938413313-11112008>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
Jay Chen.</SPAN></FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2><SPAN=20
class=3D938413313-11112008></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_011E_01C9444B.34D59BA0--
