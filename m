Return-Path: <olof@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.111])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7D11C2BDB5
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 08:03:04 +1100 (EST)
Received: from e5.ny.us.ibm.com ([9.14.6.105])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.9) with ESMTP id iALKe3tE120172
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:40:03 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.10/8.12.9) with ESMTP id iALKdDHt517820
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:39:13 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	iALKdCWk272440
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:39:12 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.12.11) with ESMTP id iALKdCZP027058
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:39:12 -0500
Date: Sun, 21 Nov 2004 11:37:11 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041121173711.GA5692@austin.ibm.com>
References: <1100847411.25521.42.camel@gaston> <1100852423.3855.2.camel@gaston>
	<1100995268.3796.39.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1100995268.3796.39.camel@gaston>
From: olof@austin.ibm.com (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 21, 2004 at 11:01:08AM +1100, Benjamin Herrenschmidt wrote:
> > Ok, I already found a bug, occasional lockups on boot and when setting
> > the backlight. I uploaded a new version at:
> 
> Here's a 3rd version. It may or may not help, as I didn't have a chance
> to test this one on either albook or ibook g4 yet. I added saving and
> restoring of a few more registers that may fix the Xv problem (or not...
> depends what X does at this point) and eventually some corruption
> problem (the bandwidth related registers weren't restored).

This one caused problems for me. Looks like the backlight got turned off
at boot, I had to sleep it and wake it up to get it back.


-Olof
