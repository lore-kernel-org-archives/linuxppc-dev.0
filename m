Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCnP53gqGzDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 15:37:28 +1000 (AEST)
Content-Type: multipart/alternative;
 boundary=Apple-Mail-2C897F81-C964-4F59-BCD7-1703DF9C0C0F
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Mime-Version: 1.0 (1.0)
Subject: PAGE_GUARDED
Message-Id: <8B4C4AB7-5C17-4992-935A-361153472793@xenosoft.de>
Date: Mon, 23 May 2016 06:38:08 +0200
To: linuxppc-dev@lists.ozlabs.org
Cc: darren@stevens-zone.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-2C897F81-C964-4F59-BCD7-1703DF9C0C0F
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Hi All,

You removed PAGE_GUARDED in the commit =20

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3D=
c04a5880299eab3da8c10547db96ea9cdffd44a6

We use

range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);

This doesn't work anymore. What can we use instead?

Thanks in advance,

Christian=

--Apple-Mail-2C897F81-C964-4F59-BCD7-1703DF9C0C0F
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><div><span></span></div><div><div>Hi All,</=
div><div><br></div><div>You removed&nbsp;<span style=3D"background-color: rg=
ba(255, 255, 255, 0);">PAGE_GUARDED in the&nbsp;commit &nbsp;</span></div><d=
iv><span style=3D"background-color: rgba(255, 255, 255, 0);"><br></span></di=
v><div><a href=3D"https://git.kernel.org/cgit/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3Dc04a5880299eab3da8c10547db96ea9cdffd44a6">https://git.ker=
nel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3Dc04a5880299eab=
3da8c10547db96ea9cdffd44a6</a></div><div><br></div><div>We use</div><div><br=
></div><div><dl class=3D"codebox" style=3D"margin: 0px; padding: 3px; border=
: 1px solid rgb(216, 208, 201);"><dd style=3D"margin: 0px; padding: 0px;"><c=
ode style=3D"margin: 2px 0px; padding: 5px 0px 0px; overflow: auto; display:=
 block; height: auto; max-height: 200px; line-height: 1.3em;"><font face=3D"=
UICTFontTextStyleBody"><span style=3D"background-color: rgba(255, 255, 255, 0=
);">range.size, _PAGE_NO_CACHE|_PAGE_GUARDED);</span></font></code></dd></dl=
></div>
</div><div><br>This doesn't work anymore. What can we use instead?<br><br></=
div><div>Thanks in advance,</div><div><br></div><div>Christian</div></body><=
/html>=

--Apple-Mail-2C897F81-C964-4F59-BCD7-1703DF9C0C0F--
