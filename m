Return-Path: <gaashpub-lnx@yahoo.com>
Received: from web32512.mail.mud.yahoo.com (web32512.mail.mud.yahoo.com
	[68.142.207.222]) by ozlabs.org (Postfix) with SMTP id B216D683D5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 03:16:13 +1000 (EST)
Message-ID: <20051013170932.88571.qmail@web32512.mail.mud.yahoo.com>
Date: Thu, 13 Oct 2005 10:09:32 -0700 (PDT)
From: <gaashpub-lnx@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: gaashpub-lnx@yahoo.com
Subject: network driver over shared memory
Reply-To: gaashpub-lnx@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Experts,

Hope this is not a too dumb question.

I have an embedded system with a few PPCs, one master
and a few slaves. All PPCs are interconnected with
shared memory over PCI.

I would like to create and IP or "Ethernet like"
network between all the PPCs to enable files transfer 
over FTP or NFS between the master and the slaves.

Is there a network driver for this in 2.6 kernel. If
not any idea where to look for or with what to begin
with.

PS: Please put my email in the reply as I'm not member
of this list (yet)

Thanks

Gaash
