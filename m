Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 0F002DDF52
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 22:38:03 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/11] celleb: move the SCC related code for celleb
Date: Wed, 5 Mar 2008 12:37:45 +0100
References: <20080305.172602.-345488266.kouish@swc.toshiba.co.jp>
In-Reply-To: <20080305.172602.-345488266.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803051237.46055.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 05 March 2008, Ishizaki Kou wrote:
> This patch moves the SCC (Super Companion Chip) related code for celleb
> into platforms/cell/.
> All files in this patch are used by celleb-beat and celleb-native commonly.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd@arndb.de>

if you address my comment to patch 2/11
