Return-Path: <Gerald.VanBaren@smiths-aerospace.com>
Received: from smtp2.smiths.com (smtp2.smiths.com [192.208.34.51])
	by ozlabs.org (Postfix) with ESMTP id 8E87D2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 22:53:49 +1000 (EST)
Received: from COSSMGIMS04.email.corp.tld (unknown [10.225.225.147])
	by smtp2.smiths.com (Postfix) with ESMTP id 9A3421C01599
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Oct 2004 06:24:15 -0600 (MDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 13 Oct 2004 06:24:12 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB864FBD@COSSMGMBX02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Embedded linux port for PowerPC ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>
>	From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Mukund JB.
> 	Sent: Wednesday, October 13, 2004 6:45 AM
> 	To: linuxppc-embedded@ozlabs.org
> 	Subject: Embedded linux port for PowerPC ?
> =0D
>	Hello all,
>
>	This is my first visit to the mailists.=0D
>	I have assigned to port Embedded Linux to PowerPC Board.
>	=0D
>	Where do I get the Embedded Linux kernel & Source code for
PowerPC?
>	Can you provide me with some documents related to porting
Embedded Linux to PowerPC Board?
>	How do I know the available Embedded Linux ports for PowerPC?
>
>	Regards,
>
>	Mukund jampala

See
  <http://denx.de/e/index1.php?head=3Dsolution-se-head>

Download the Embedded Linux Development Kit (ELDK) from
<http://www.denx.de>
=0D
http://denx.de/e/index1.php?head=3Ddocs-head&main=3Ddocs&subnav=
=3Ddocs-subnav&
logo=3Dlogo-se&mainnav=3Ddocsnav&bottom=3Dbottom-se
This is the #1 easiest solution (in my book at least) to a cross
development environment.

Read the documentation there DENX U-Boot and Linux Guide (DULG) -- while
it says 8xx, it generally applies to all PowerPCs.
  <http://www.denx.de/twiki/bin/view/DULG/Manual>

If you need a boot loader (quite likely), look at u-boot.  Download it
and read the README file for instructions on how to port it to your
hardware.  U-boot is also associated with Wolfgang Denks (denx.de).
  <http://sourceforge.net/projects/u-boot>

Good luck and read carefully.  There is a wealth of good information in
those resources.

gvb

******************************************
The following messages are brought to you by the Lawyers' League of
IdioSpeak:

******************************************
The information contained in, or attached to, this e-mail, may contain=
 confidential information and is intended solely for the use of the=
 individual or entity to whom they are addressed and may be subject to=
 legal privilege.  If you have received this e-mail in error you should=
 notify the sender immediately by reply e-mail, delete the message from=
 your system and notify your system manager.  Please do not copy it for any=
 purpose, or disclose its contents to any other person.  The views or=
 opinions presented in this e-mail are solely those of the author and do=
 not necessarily represent those of the company.  The recipient should=
 check this e-mail and any attachments for the presence of viruses.  The=
 company accepts no liability for any damage caused, directly or=
 indirectly, by any virus transmitted in this email.
******************************************
