Return-Path: <lk.atwork@yahoo.com>
Received: from n54.bullet.mail.sp1.yahoo.com (n54.bullet.mail.sp1.yahoo.com
	[98.136.44.32]) by ozlabs.org (Postfix) with SMTP id EF10BDDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Aug 2008 04:16:13 +1000 (EST)
Date: Wed, 27 Aug 2008 11:16:11 -0700 (PDT)
From: Laxmikant Rashinkar <lk.atwork@yahoo.com>
Subject: How to access Freesale UPM NAND device
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2012070766-1219860971=:68184"
Message-ID: <765252.68184.qm@web46305.mail.sp1.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-2012070766-1219860971=:68184
Content-Type: text/plain; charset=us-ascii

Hi,

quick question:

I have a custom board running MPC8347 on Linux 2.6.27 with Uboot 1.1.4.
I also have a NAND device (Micron MT29F2G08AACWP) connected to the LBC
and controlled via UPM.

fsl_elbc_nand.ko, fsl_upm.ko are loaded.

I'm wondering how to access the NAND device. Do I need mDOC? TrueFFS?

I have grep'd for the functions declared in fsl_upm.c and fsl_lbc.c and find that no other
code path calls these functions. So it looks like the drivers are loaded but no one calls into
them.

any help appreciated.

thanks
LK


      
--0-2012070766-1219860971=:68184
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:times new roman, new york, times, serif;font-size:12pt"><div>Hi,<br><br>quick question:<br><br>I have a custom board running MPC8347 on Linux 2.6.27 with Uboot 1.1.4.<br>I also have a NAND device (Micron MT29F2G08AACWP) connected to the LBC<br>and controlled via UPM.<br><br>fsl_elbc_nand.ko, fsl_upm.ko are loaded.<br><br>I'm wondering how to access the NAND device. Do I need mDOC? TrueFFS?<br><br>I have grep'd for the functions declared in fsl_upm.c and fsl_lbc.c and find that no other<br>code path calls these functions. So it looks like the drivers are loaded but no one calls into<br>them.<br><br>any help appreciated.<br><br>thanks<br>LK<br><br></div></div><br>

      </body></html>
--0-2012070766-1219860971=:68184--
