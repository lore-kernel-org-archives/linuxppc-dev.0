Return-Path: <olof@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97A7167A76
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 08:54:32 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j1OLsRJo001469
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 16:54:27 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1OLsRm1052470
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 16:54:27 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j1OLsR0k015885
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 16:54:27 -0500
Received: from localhost.localdomain (dyn953186154.austin.ibm.com
	[9.53.186.154])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j1OLsR82015868
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2005 16:54:27 -0500
Date: Thu, 24 Feb 2005 15:50:07 -0600
To: linuxppc-dev@ozlabs.org
Message-ID: <20050224215007.GC15818@austin.ibm.com>
References: <20050216181430.GA27031@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050216181430.GA27031@austin.ibm.com>
From: olof@austin.ibm.com (Olof Johansson)
Subject: Re: iBook G4: first wakeup has black screen
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 16, 2005 at 12:14:30PM -0600, Olof Johansson wrote:

> I've noticed one thing though: The very first time I wake the machine up
> after sleeping the screen is dark (backlight off?). If I put it to sleep
> and wake it up again everything goes back to normal.

... seems fixed in 2.6.11-rc5, at least I have yet to reproduce it.


-Olof
