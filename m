Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [12.110.71.38])
	by ozlabs.org (Postfix) with ESMTP id C61E9DDF92
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 08:56:21 +1000 (EST)
Received: from edison2.selinc.com (edison2.selinc.com [12.110.71.57])
	by duster.selinc.com (Spam Firewall) with ESMTP id C90014D8C74
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 15:56:20 -0700 (PDT)
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC2795DD@twx-exch01.twacs.local>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Still trying to get a stable 2.6.20.4 running on 8349ITX
	eval	board
MIME-Version: 1.0
Message-ID: <OF209229BB.1AF7E208-ON882572BA.007D48D9-882572BA.007E0163@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Wed, 11 Apr 2007 15:56:18 -0700
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michael,

linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 04/11/2007 
01:59:11 PM:

> 
> >2) I assume someone (Kumar?) has gotten some combination of 
> >kernel/FS to 
> >boot and run on this box.  What combination is that?
> 
> I am thinking that these issues are closely coupled to root NFS.  I know
> this isn't good news, but I think the combo is running the root
> filesystem on the hard drive or ramdisk.
>    Good luck,
>       Michael
> 
For the heck of it, we tried formatting the hard drive, put ubuntu/dapper 
on a ext3 partition, and used that as the root FS.  Same results.  We 
booted with init=/bin/sh but when we run debootstrap --second-stage it got 
just a few seconds into it and locked up in a program exception.

Thanks for the input though.  I'll keep poking and let you know what I 
figure out.  I keep hoping some guru out there will go "ahhhh......" 
'cause I ain't no guru!  :)

Bruce


------------------------------------------------

This e-mail may contain SEL confidential information.  The opinions
expressed are not necessarily those of SEL.  Any unauthorized disclosure,
distribution or other use is prohibited.  If you received this e-mail in
error, please notify the sender, permanently delete it, and destroy any
printout.

Thank you.

------------------------------------------------
