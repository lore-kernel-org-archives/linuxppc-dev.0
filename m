Return-Path: <Sendhilraj.T@Lntemsys.com>
Received: from mail85.messagelabs.com (mail85.messagelabs.com [216.82.240.99])
	by ozlabs.org (Postfix) with SMTP id 4DC6BDDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 16:39:44 +1100 (EST)
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Porting JFFS2 to 2.4.6 kernel
MIME-Version: 1.0
Message-ID: <OFB2115A72.B614B566-ON65257281.001F4CE3-65257281.001F5609@lntemsys.com>
From: Sendhilraj T <Sendhilraj.T@Lntemsys.com>
Date: Tue, 13 Feb 2007 11:13:54 +0530
Content-Type: multipart/alternative;
	boundary="=_alternative 001F560665257281_="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 001F560665257281_=
Content-Type: text/plain; charset="US-ASCII"

Hello all,
I am trying to downport JFFS2 from 2.4.16 to 2.4.6 kernel. After including 
the patch for JFFS2 and enabling the JFFS2 configuration in the .config 
file if I restart ,the kernel is not getting booted.However if i disable 
the JFFS2 configuraton in the patched kernel, it successfully boots....
May I know the reason?
Also I would like to know is there any working patch for JFFS2 available 
for 2.4.6 kernel?
Could anyone help us in this regard?

T.Sendhil
--=_alternative 001F560665257281_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=3>Hello all,<br>
I am trying to downport JFFS2 from 2.4.16 to 2.4.6 kernel. After including
the patch for JFFS2 and enabling the JFFS2 configuration in the .config
file if I restart ,the kernel is not getting booted.However if i disable
the JFFS2 configuraton in the patched kernel, it successfully boots....<br>
May I know the reason?</font>
<br><font size=3>Also I would like to know is there any working patch for
JFFS2 available for 2.4.6 kernel?<br>
Could anyone help us in this regard?</font>
<br><font size=3><br>
T.Sendhil</font>
--=_alternative 001F560665257281_=--
