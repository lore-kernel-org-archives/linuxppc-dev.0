Return-Path: <olof@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 777C067A75
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Feb 2005 07:37:07 +1100 (EST)
Received: from westrelay01.boulder.ibm.com (westrelay01.boulder.ibm.com
	[9.17.195.10])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j1GKaw0D648158
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Feb 2005 15:36:59 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay01.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1GKawMx141062
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Feb 2005 13:36:58 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1GKawA3027366
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Feb 2005 13:36:58 -0700
Date: Wed, 16 Feb 2005 12:14:30 -0600
To: linuxppc-dev@ozlabs.org
Message-ID: <20050216181430.GA27031@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@austin.ibm.com (Olof Johansson)
Subject: iBook G4: first wakeup has black screen
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

With 2.6.11-rc4, sleep seems to work pretty well. There's still problems
with disconnecting USB devices while the machine is asleep, but that's
nothing new.

I've noticed one thing though: The very first time I wake the machine up
after sleeping the screen is dark (backlight off?). If I put it to sleep
and wake it up again everything goes back to normal.

The machine is an iBook G4 1.2GHz:
0000:00:10.0 VGA compatible controller: ATI Technologies Inc RV250 5c63
[Radeon Mobility 9200 M9+] (rev 01)

Has anyone else seen this before?


-Olof
