Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id B55E12BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 19:27:16 +1000 (EST)
Message-ID: <1097227736.41665dd81009b@webmail.televes.com:443>
Date: Fri,  8 Oct 2004 11:28:56 +0200
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Bridge, promiscous mode andCPM2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I would need confirmation on this.

As long as I have seen, bridge's stuff in kernel sets promiscous mode by using
dev_set_promiscuity, which arrives in the execution of fcc_enet's
set_multicast_list.

But this function is not developed, so the promiscous mode is never set in the
FCC Ethernet Mode Register.

Am I right? By now, I only needs the promiscous mode, so, could it be a solution
to implement only this functionality in the set_multicast_list function? Do I
need to consider anything else?

Best regards

Alexandre Bastos
