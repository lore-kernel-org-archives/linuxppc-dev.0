Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id EB10FDDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 07:50:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: settimeofday not working
Date: Thu, 25 Oct 2007 16:50:05 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B038A2789@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B038A269F@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B038A269F@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Rune Torgersen" <runet@innovsys.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From:  Rune Torgersen
> Sent: Thursday, October 25, 2007 2:40 PM

> On any kernel newer than 2.6.20, settimeofday does not work.
> I try to set the current date, but when I read back the time, it is
> still the old date (in our case, Jan 1 1970)

Eventually the date actually got updated. Before then it returned 00:00
Jan 1 1970 every time it was queried.

Anyways. Updated to 2.6.24-rc1, and it seems to work correctly.
