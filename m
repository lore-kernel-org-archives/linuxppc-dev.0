Return-Path: <woyuzhilei@163.com>
Received: from m5-83.163.com (m5-83.163.com [202.108.5.83])
	by ozlabs.org (Postfix) with SMTP id 0652BDDE44
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 13:27:26 +1000 (EST)
Date: Fri, 24 Aug 2007 11:11:57 +0800
From: "woyuzhilei" <woyuzhilei@163.com>
To: "grant.likely" <grant.likely@secretlab.ca>
Subject: Problems on porting linux 2.6 to xilinx ML410
Message-ID: <200708241111513591137@163.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon205437746728_====="
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
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

--=====003_Dragon205437746728_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hey:
    Recently I'm doing some project on Xilinx Ml410 evaluation board.The first step is porting linux 2.6 to ml410,but I got some problems on this,and my project cann't proceed,so I come to you for some help.
    I use the linux kernel source tree download from  http://git.secretlab.ca/git/linux-2.6-virtex.git  (The latest one).Add the file the xparameters.h,xparameter_ml40x.h.  Then add arch/ppc/platforms/4xx/xilinx_generic_ppc.c(Use the patch I get here),and change it's name to ml40x.c,then I make some necessay change of the configuration files to accept selecting a Ml40x type board.Then compile the kernel,and get the image file from arch/ppc/boot/images, (On kernel compiling,the only device driver  I sellect is " 8250/16550 and compatible serial support ").After that  I download the zImage.elf file to the target board,and run it.But there is no output from the serial port at all.Am I doing somthing wrong?I really don't know goes wrong.
    Can anyone here help me with this?Any help from you is appreciated.Thank you very much!

        


                                                                                                                                                                                    woyuzhilei
                                                                                                                                                                                     2007-08-24

--=====003_Dragon205437746728_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2180" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Verdana><FONT size=2>Hey:</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2>&nbsp;&nbsp;&nbsp; Recently I'm doing some 
project on Xilinx Ml410 evaluation board.The first step is porting linux 2.6 to 
ml410,but I got some problems on this,and my project cann't proceed,so I come to 
you for some help.</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2>&nbsp;&nbsp;&nbsp; I use the linux kernel 
source tree download from&nbsp; <A 
href="http://git.secretlab.ca/git/linux-2.6-virtex.git">http://git.secretlab.ca/git/linux-2.6-virtex.git</A></FONT></FONT>&nbsp;<FONT 
face=Verdana><FONT size=2><FONT face="Times New Roman" size=3>&nbsp;</FONT>(The 
latest one).Add the file the xparameters.h,xparameter_ml40x.h.&nbsp; Then add 
arch/ppc/platforms/4xx/xilinx_generic_ppc.c(Use the patch I get here),and change 
it's name to ml40x.c,then I make some necessay change of the configuration files 
to accept selecting a Ml40x type board.Then&nbsp;compile the kernel,and&nbsp;get 
the image file from&nbsp;arch/ppc/boot/images,&nbsp;(On kernel compiling,the 
only&nbsp;device driver &nbsp;I sellect is " 8250/16550 and compatible serial 
support ").After that&nbsp; I download the zImage.elf file to the target 
board,and run it.But there is no output from the serial&nbsp;port at all.Am I 
doing somthing wrong?I really don't know goes wrong.</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2>&nbsp;&nbsp;&nbsp; Can anyone here help me with 
this?Any help from you is appreciated.Thank you very much!</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT><FONT face=Verdana><FONT 
size=2>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
<HR style="WIDTH: 962px; HEIGHT: 3px" SIZE=3>
</DIV></FONT>
<DIV><FONT color=#c0c0c0><FONT size=2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; woyuzhilei</FONT></DIV>
<DIV><FONT 
size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; 
&nbsp;&nbsp;&nbsp;2007-08-24</FONT></FONT></DIV></FONT></BODY></HTML>

--=====003_Dragon205437746728_=====--
