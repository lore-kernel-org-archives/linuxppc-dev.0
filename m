Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 4A06C68011
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 04:21:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 9 Aug 2005 13:21:09 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85941B@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Wall clock accuracy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Eugene Surovegin [mailto:ebs@ebshome.net]=20
> Sent: Tuesday, August 09, 2005 12:21

> Fair enough, why then instead of fixing the root cause you are making=20
> ugly workarounds :) ?

Probably because I did not want to fiddle with the code that did the
original calculation, and I wanted to see if I could get it totally
accurate (for the case where there is not a whole number of ns in a
jiffy).

A proper fix would be for platfrom code to have a way to set time_nsec
instead of having it set by a constant.

I did say in my original email that thencluded code was not a proper
patch but more something to show on how a fix could look like, and to
start a discussion about it.
