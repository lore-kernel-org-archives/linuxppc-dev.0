Return-Path: <minyard@acm.org>
Received: from mta16.adelphia.net (mta16.mail.adelphia.net [68.168.78.211])
	by ozlabs.org (Postfix) with ESMTP id 7339BDDE40
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 15:18:18 +1100 (EST)
Message-ID: <45BD6EB4.2040108@acm.org>
Date: Sun, 28 Jan 2007 21:49:08 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Openipmi-developer] [patch 1/1] next updated version,	fixed
	cleanup and some minors
References: <20061218163846.337fed65@localhost>
	<45882913.2000609@acm.org>	<20061220154517.6341fce6@localhost>	<200612210111.28186.arnd@arndb.de>	<20070125104540.65a1f557@localhost>	<DA5708FC-F9AB-4782-A48D-40B26990A24F@kernel.crashing.org>	<20070125143056.47cbd5d2@localhost>
	<20070125143415.10f43bfa@localhost>
In-Reply-To: <20070125143415.10f43bfa@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry, I've been traveling and haven't been able to follow this until now.

This should probably wait for 2.6.20, so I will hold it until the merge 
window
opens and send it on with a proper subject.

Thanks for noticing that the cleanup code now handles dynamic removal of
devices even when the driver is not being removed.

As for putting this in another file, that might be a good idea.  It also 
might
be a good idea to put the PCI, SMBIOS, and ACPI versions in their own
files, too.  I'll try to get that for the 2.6.20 merge window.

-Corey
