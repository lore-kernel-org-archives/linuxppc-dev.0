Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id A00C0DDEFD
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 17:23:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/14] ps3: get firmware version
Date: Thu, 25 Jan 2007 07:23:48 +0100
References: <45B81891.1010309@am.sony.com>
In-Reply-To: <45B81891.1010309@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250723.48555.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 03:40, Geoff Levand wrote:
> Output the PS3 firmware version to dmesg and /proc/cpuinfo.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

I agree with benh that you should avoid the copy of individual fields
inside of the struct ps3_firmware_version, since you can directly
read into a 

struct ps3_firmware_version {
	u16 pad;
	u16 major;
	u16 minor;
	u16 rev;
};
