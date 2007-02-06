Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 36A7ADDDEB
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 23:56:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [v2] [3/8] pasemi: Idle loops
Date: Tue, 6 Feb 2007 13:56:31 +0100
References: <20070204223648.767950000@lixom.net>
	<20070204223648.767950000@lixom.net>>
	<20070204223752.500830000@lixom.net>>
In-Reply-To: <20070204223752.500830000@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702061356.32566.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 04 February 2007 23:36, Olof Johansson wrote:
> Powersave support on PA6T. Right now it only uses 'doze' mode, and
> will default to no savings (spin).
 
Yes, looks good now. Since you support two methods for powersave,
would it make sense to add a way to change the setting at run time?
It should be easy enough to add a sysfs entry or sysctl for this
in the future.

> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
