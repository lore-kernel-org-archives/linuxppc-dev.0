Return-Path: <Gerald.VanBaren@smiths-aerospace.com>
Received: from smtp1.smiths.com (smtp1.smiths.com [192.208.34.50])
	by ozlabs.org (Postfix) with ESMTP id 60BBA2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 22:50:18 +1000 (EST)
Received: from COSSMGIMS01.email.corp.tld (unknown [10.225.225.177])
	by smtp1.smiths.com (Postfix) with ESMTP id 61EFE1C00AD5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 06:50:04 -0600 (MDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 29 Oct 2004 06:50:00 -0600
Message-ID: <065ACD8E84315E4394C835E398C8D5EB95AABA@COSSMGMBX02.email.corp.tld>
From: "VanBaren, Gerald (AGRE)" <Gerald.VanBaren@smiths-aerospace.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: CLI for Embedded Systems
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Mukund JB.
> Sent: Friday, October 29, 2004 2:38 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: CLI for Embedded Systems
>=0D
>=0D
> Hello all,
> Good news. Linux on a new device.
> =0D
> Now, we are porting Linux to a Intrusion Detection & protection
Device.
> I need some help in finding out Embedded Command Line Interface (CLI).
> =0D
> Where can I find the source code & some documentation about CLI?
> =0D
> Thanks for the help in advance.
> =0D
> Regards,
> Mukund jampala


Check out the "hush" shell
  http://www.cs.vu.nl/~eliens/online/hush/index.html
an example of the use of hush in an embedded environment is u-boot
  http://www.denx.de/twiki/bin/view/DULG/CommandLineParsing
I assume the first link is what is used in u-boot, I did not look into
it closely (my doubts are because the hush shell in the first link talks
about C++ and u-boot is C).

Check out BusyBox
  http://www.busybox.net/

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
