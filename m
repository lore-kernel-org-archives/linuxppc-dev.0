Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 33DC2DE00D
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 22:53:11 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/11] cell: generalize io-workarounds code
Date: Wed, 5 Mar 2008 12:52:54 +0100
References: <20080305.173611.1791041378.kouish@swc.toshiba.co.jp>
In-Reply-To: <20080305.173611.1791041378.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803051252.54720.arnd@arndb.de>
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
> This patch splits cell io-workaround code into spider-pci dependent
> code and a generic part, and also adds interfaces to the generic
> io-workaround mechanism.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> ---
> 
> Please test on CellBlade because I don't have any access to CellBlade.
> 

Ok, I'll ask around for volunteers to test it, he patch looks good so far.
