Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8546B679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Jul 2006 04:50:35 +1000 (EST)
Subject: Re: page locking in PowerPC cores
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Parav Pandit <paravpandit@yahoo.com>
In-Reply-To: <20060719044510.24117.qmail@web36604.mail.mud.yahoo.com>
References: <20060719044510.24117.qmail@web36604.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 14:50:20 -0400
Message-Id: <1153421420.16159.7.camel@localhost.localdomain>
Mime-Version: 1.0
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

Only memory mapped into userland contexts can be paged out in the first
place.

Ben.
