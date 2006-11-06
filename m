Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.189])
	by ozlabs.org (Postfix) with ESMTP id 01FD567C7C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 04:13:37 +1100 (EST)
Date: Mon, 6 Nov 2006 17:58:35 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [Fwd: [Bug 7431] New: ohci1394 Oops after a rmmod/modprobe	cycle]
Message-ID: <20061106165752.GA25595@aepfle.de>
References: <454DBFE7.3090800@s5r6.in-berlin.de>
	<1162724083.28571.235.camel@localhost.localdomain>
	<454DC985.2020203@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <454DC985.2020203@s5r6.in-berlin.de>
Cc: Gioele Barabucci <dev@gioelebarabucci.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 05, Stefan Richter wrote:

> Yes, PowerBook G3 Pismo seems affected.
> https://bugzilla.novell.com/show_bug.cgi?id=115228

This patch does not help. Doing an ip link set dev eth0 up makes no
difference.
