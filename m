Return-Path: <bgat@billgatliff.com>
Received: from smtp122.sbc.mail.re3.yahoo.com (smtp122.sbc.mail.re3.yahoo.com
	[66.196.96.95]) by ozlabs.org (Postfix) with SMTP id 21DBBDDF1D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 02:12:18 +1000 (EST)
Message-ID: <466D7169.1000407@billgatliff.com>
Date: Mon, 11 Jun 2007 10:59:37 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Laurent Lagrange <lagrange@fr.oleane.com>
Subject: Re: Linux 2.6.x, MTD drivers and NAND flashes
References: <000001c7ac3c$15e7da80$5201a8c0@GEG2400>
In-Reply-To: <000001c7ac3c$15e7da80$5201a8c0@GEG2400>
Content-Type: multipart/alternative;
	boundary="------------050102040909040701090807"
Cc: linuxppc-embedded@ozlabs.org
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
--------------050102040909040701090807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Laurent Lagrange wrote:
> Hello,
>
> I use a Linux 2.6.9 on a 85xx custom board with a NAND flash.
>  
> This flash has some bad blocks.
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 
> 3,3V 8-bit)
> Scanning device for bad blocks
> Bad eraseblock 8 at 0x00100000
> Bad eraseblock 430 at 0x035c0000
> ...
> Creating 1 MTD partitions on "NAND 128MiB 3,3V 8-bit":
> 0x00000000-0x08000000 : "flash partition 1".
>  
> I have selected in the kernel :
> 1) the MTD character and block supports for NAND,
> 2) the CRAMFS and JFFS2 supports for NAND.
>  
> I can erase the flash but receive IO errors for each bad blocks (that 
> seems right).
> I can mount an empty JFFS2 partition on the NAND and untar some 
> directories and files in it.
>  
> I would like to generate some JFFS2 images and program them in the 
> flash with a character
> command like "cat img > /dev/mtd/0". If I dont encounter a bad block, 
> it runs right else the
> command fails.
>  
> This is a little bit annoying. So my question is simple :
> Is there a MTD character driver which can detect and ignore the bad 
> blocks in a NAND flash ?

Wrong question.  :)

With NAND, working directly with the media is indeed a pain because of 
bad blocks.  What's done instead is to leave that to the filesystem.  
Pick a NAND-aware one like YAFFS.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


--------------050102040909040701090807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Laurent Lagrange wrote:
<blockquote cite="mid000001c7ac3c$15e7da80$5201a8c0@GEG2400" type="cite">
  <meta http-equiv="Content-Type" content="text/html; ">
  <title></title>
  <meta content="MSHTML 6.00.6000.16441" name="GENERATOR">
  <div><font face="Arial" size="2">Hello,<br>
  <br>
I use a Linux 2.6.9 on a 85xx custom board with a NAND flash. </font></div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">This flash has some bad blocks.</font></div>
  <div><font face="Arial" size="2">NAND device: Manufacturer ID: 0xec,
Chip ID: 0xf1 (Samsung NAND 128MiB 3,3V 8-bit)<br>
Scanning device for bad blocks<br>
Bad eraseblock 8 at 0x00100000<br>
Bad eraseblock 430 at 0x035c0000</font></div>
  <div><font face="Arial" size="2">...<br>
Creating 1 MTD partitions on "NAND 128MiB 3,3V 8-bit":<br>
0x00000000-0x08000000 : "flash partition 1".</font></div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">I have selected in the kernel :</font></div>
  <div><font face="Arial" size="2">1) the MTD character and block
supports for NAND,</font></div>
  <div><font face="Arial" size="2">2) the CRAMFS and JFFS2 supports for
NAND.</font></div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">I can erase the flash but receive IO
errors for each bad blocks (that seems right).</font></div>
  <div><font face="Arial" size="2">I can mount an empty JFFS2 partition
on the NAND and untar some directories and files in it.</font></div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">I would like to generate some JFFS2
images and program them in the flash </font><font face="Arial" size="2">with
a character </font></div>
  <div><font face="Arial" size="2">command like "cat img &gt;
/dev/mtd/0". </font><font face="Arial" size="2">If I dont encounter a
bad block, it runs right&nbsp;else the </font></div>
  <div><font face="Arial" size="2">command fails. </font></div>
  <div>&nbsp;</div>
  <div><font face="Arial" size="2">This is a little bit annoying. So m</font><font
 face="Arial" size="2">y question is simple : </font></div>
  <div><font face="Arial" size="2">Is there a MTD character driver
which can detect and ignore the bad blocks in a NAND flash&nbsp;? <br>
  </font></div>
</blockquote>
<br>
Wrong question.&nbsp; :)<br>
<br>
With NAND, working directly with the media is indeed a pain because of
bad blocks.&nbsp; What's done instead is to leave that to the filesystem.&nbsp;
Pick a NAND-aware one like YAFFS.<br>
<br>
<br>
b.g.<br>
<pre class="moz-signature" cols="72">-- 
Bill Gatliff
<a class="moz-txt-link-abbreviated" href="mailto:bgat@billgatliff.com">bgat@billgatliff.com</a>
</pre>
</body>
</html>

--------------050102040909040701090807--
