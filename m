Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EF88B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 22:38:15 +1000 (EST)
In-Reply-To: <1273518917-10229-1-git-send-email-felix@embedded-sol.com>
Subject: Re: [PATCH] 85xx: Fix PCI-E interrupt mapping for slot 0 of P2020DS
Mime-Version: 1.0 (Apple Message framework v1078)
Date: Tue, 11 May 2010 07:35:24 -0500
Message-Id: <35A67424-AF60-4FB0-A43C-63633FE20803@kernel.crashing.org>
To: Felix Radensky <felix@embedded-sol.com>
From: Kumar Gala <galak@kernel.crashing.org>
References: <> <1273518917-10229-1-git-send-email-felix@embedded-sol.com>
Content-Type: text/html; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<html><body class=3D"ApplePlainTextBody" style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><br>On May 10, 2010, at 2:15 PM, Felix Radensky =
wrote:<br><br><blockquote type=3D"cite">Fix legacy PCI-E interrupt =
mapping for PCI-E slot 0 of<br></blockquote><blockquote =
type=3D"cite">P2020DS evaluation board. The patch is based on =
P2020DS<br></blockquote><blockquote type=3D"cite">device tree from =
Freescale BSP for this board.<br></blockquote><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">Signed-off-by: =
Felix Radensky =
&lt;felix@embedded-sol.com&gt;<br></blockquote><blockquote =
type=3D"cite">---<br></blockquote><blockquote =
type=3D"cite">arch/powerpc/boot/dts/p2020ds.dts | &nbsp; &nbsp;8 =
++++----<br></blockquote><blockquote type=3D"cite">1 files changed, 4 =
insertions(+), 4 deletions(-)<br></blockquote><br>I don't understand why =
this is needed?<br><br>-k<br><br><blockquote =
type=3D"cite"><br></blockquote><blockquote type=3D"cite">diff --git =
a/arch/powerpc/boot/dts/p2020ds.dts =
b/arch/powerpc/boot/dts/p2020ds.dts<br></blockquote><blockquote =
type=3D"cite">index 1101914..7c5fc07 100644<br></blockquote><blockquote =
type=3D"cite">--- =
a/arch/powerpc/boot/dts/p2020ds.dts<br></blockquote><blockquote =
type=3D"cite">+++ =
b/arch/powerpc/boot/dts/p2020ds.dts<br></blockquote><blockquote =
type=3D"cite">@@ -507,10 +507,10 @@<br></blockquote><blockquote =
type=3D"cite"><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>interrupt-map-mask =3D &lt;0xf800 0x0 0x0 =
0x7&gt;;<br></blockquote><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>interrupt-map =3D &lt;<br></blockquote><blockquote =
type=3D"cite"><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>/* IDSEL 0x0 */<br></blockquote><blockquote type=3D"cite">-<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x1 &amp;mpic 0x8 0x1<br></blockquote><blockquote type=3D"cite">-<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x2 &amp;mpic 0x9 0x1<br></blockquote><blockquote type=3D"cite">-<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x3 &amp;mpic 0xa 0x1<br></blockquote><blockquote type=3D"cite">-<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x4 &amp;mpic 0xb 0x1<br></blockquote><blockquote type=3D"cite">+<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x1 &amp;mpic 0x8 0x2<br></blockquote><blockquote type=3D"cite">+<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x2 &amp;mpic 0x9 0x2<br></blockquote><blockquote type=3D"cite">+<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x3 &amp;mpic 0xa 0x2<br></blockquote><blockquote type=3D"cite">+<span=
 class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>0000 0x0 =
0x0 0x4 &amp;mpic 0xb 0x2<br></blockquote><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>&gt;;<br></blockquote><blockquote type=3D"cite"><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>pcie@0 =
{<br></blockquote><blockquote type=3D"cite"><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>reg =3D &lt;0x0 0x0 0x0 0x0 =
0x0&gt;;<br></blockquote><blockquote =
type=3D"cite">--&nbsp;<br></blockquote><blockquote =
type=3D"cite">1.5.4.3<br></blockquote><br></body></html>=
