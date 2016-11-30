Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTPHB3yW5zDvt3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 02:20:06 +1100 (AEDT)
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tTPHB011Zz9ssP
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2016 02:20:05 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andreas Schwab' <schwab@linux-m68k.org>, Benjamin Herrenschmidt
 <benh@au1.ibm.com>
CC: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH v2] adb: properly mark continued kernel messages
Date: Wed, 30 Nov 2016 14:50:41 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02303EA@AcuExch.aculab.com>
References: <87r35ynzoe.fsf@linux-m68k.org>
 <1480200189.11342.4.camel@au1.ibm.com> <87oa0zpcvg.fsf_-_@linux-m68k.org>
In-Reply-To: <87oa0zpcvg.fsf_-_@linux-m68k.org>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andreas Schwab
> Sent: 28 November 2016 20:29
> Use pr_cont where appropriate, and switch to pr_foo throughout.
> Additionally, lower messages in adb_probe_task to debug level.

Doesn't pr_cont() have its own major problem - garbled messages if
there are concurrent writers?
So it is best avoided if at all possible.

	David
=20
