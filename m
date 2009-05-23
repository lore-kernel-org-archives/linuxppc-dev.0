Return-Path: <hunter.cobbs@gmail.com>
Received: from mail-qy0-f128.google.com (mail-qy0-f128.google.com
	[209.85.221.128]) by ozlabs.org (Postfix) with ESMTP id 78696DE000
	for <linuxppc-dev@ozlabs.org>; Sat, 23 May 2009 13:54:59 +1000 (EST)
Received: by qyk34 with SMTP id 34so3897784qyk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 20:54:57 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 22 May 2009 22:48:40 -0500
Message-ID: <ad84a70a0905222048i4e7ae5ddp66418f96d531f5f3@mail.gmail.com>
Subject: PPC405EX based irq flooding with USB-OTG and usbserial device
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00163642719eb5f806046a8c40dc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00163642719eb5f806046a8c40dc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello everyone,

This is my first post to the PPC dev list as my company has just started
developing a new project based on Linux.  The good news is, this post is not
debug-related as much as it is an introduction and query while I download
the latest DENX kernel(only place I know that has the DWC_OTG driver).

I've been working with a Kilauea dev board and have had lots of trouble when
I plug in a sierra-wireless modem dev kit on the USB.  It goes fine untill I
actually try to communicate(pppd or minicom) with the little bugger and then
my IRQs go through the roof.  And they only calm back down after I shut down
my communicaiton channel.

I've solved this issue with our board, and was wondering if it has since
been fixed (I'm running 2.6.25-DENX).  I don't want to waste the board's
time with a patch that is no longer necesarry.

-- 
Hunter Cobbs

--00163642719eb5f806046a8c40dc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello everyone, <br><br>This is my first post to the PPC dev list as my com=
pany has just started developing a new project based on Linux.=A0 The good =
news is, this post is not debug-related as much as it is an introduction an=
d query while I download the latest DENX kernel(only place I know that has =
the DWC_OTG driver).<br>
<br>I&#39;ve been working with a Kilauea dev board and have had lots of tro=
uble when I plug in a sierra-wireless modem dev kit on the USB.=A0 It goes =
fine untill I actually try to communicate(pppd or minicom) with the little =
bugger and then my IRQs go through the roof.=A0 And they only calm back dow=
n after I shut down my communicaiton channel.<br>
<br>I&#39;ve solved this issue with our board, and was wondering if it has =
since been fixed (I&#39;m running 2.6.25-DENX).=A0 I don&#39;t want to wast=
e the board&#39;s time with a patch that is no longer necesarry.<br clear=
=3D"all">
<br>-- <br>Hunter Cobbs<br>

--00163642719eb5f806046a8c40dc--
