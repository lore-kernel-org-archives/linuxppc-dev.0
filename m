Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 0EAB1B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Dec 2010 00:04:39 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] spufs: use simple_write_to_buffer
Date: Thu, 30 Dec 2010 14:04:26 +0100
References: <n> <1293257039-2580-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1293257039-2580-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201012301404.27090.arnd@arndb.de>
Cc: cbe-oss-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Saturday 25 December 2010, Akinobu Mita wrote:
> Simplify several write fileoperations for spufs by using
> simple_write_to_buffer().
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Jeremy Kerr <jk@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: cbe-oss-dev@lists.ozlabs.org

Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>
