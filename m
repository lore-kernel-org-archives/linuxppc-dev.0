Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 7E172DE1E4
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 20:59:32 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 11/16] ps3: fix interrupt bmp
Date: Sat, 27 Jan 2007 10:59:16 +0100
References: <45BAC220.1060304@am.sony.com>
In-Reply-To: <45BAC220.1060304@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701271059.17111.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 January 2007 04:08, Geoff Levand wrote:
> Add a comment and a preprocessor macro to help clearify the alignment
> needs of the PS3 interrupt bitmap.
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
