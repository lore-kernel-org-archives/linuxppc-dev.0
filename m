Return-Path: <olof@lixom.net>
Date: Wed, 12 Apr 2006 15:18:24 -0500
To: paulus@ozlabs.org
Subject: [0/10]: Clean up boot time console messages
Message-ID: <20060412201823.GG19464@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Olof Johansson <olof@lixom.net>
Cc: hollisb@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a series of patches that removes a bunch of console messages during PPC
boot. They are moved to KERN_DEBUG instead, which means that:

1. They will still be in dmesg.
2. If needed for debugging, they can be enabled by adding "loglevel=8" to the
boot command line.

But for most uses, I don't see how these messages really add value to the user.
The information is normally available at other places, and mostly needed when
trying to figure out why something doesn't work right.

Since these are all janitorial, I'd appreciate them being queued for 2.6.18.


-Olof
