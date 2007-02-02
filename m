Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id E9DE7DDDF5
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:04:16 +1100 (EST)
Message-Id: <20070202045448.145851000@lixom.net>>
Date: Thu, 01 Feb 2007 22:54:48 -0600
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] [0/9] PA Semi patches
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series fills in a lot of the missing pieces from the PA
Semi platform. In addition to these ones, the smbus and ethernet drivers
have been posted on their respective lists.

These are meant to be applied on top of the PMC cleanups that were posted
earlier (Subject: PMC-related cleanups [v2]).

Paul, please consider these for the 2.6.21 merge window.


Thanks,

-Olof
