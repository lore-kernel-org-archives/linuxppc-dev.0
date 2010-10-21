Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id DE669B70FC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Oct 2010 02:08:27 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH v2 02/22] bitops: rename generic little-endian bitops
	functions
Date: Thu, 21 Oct 2010 17:07:16 +0200
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com>
	<1287672077-5797-3-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1287672077-5797-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201010211707.17049.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, rds-devel@oss.oracle.com, kvm@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Christoph Hellwig <hch@infradead.org>,
	Andy Grover <andy.grover@oracle.com>,
	linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Avi Kivity <avi@redhat.com>, Greg Ungerer <gerg@uclinux.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 21 October 2010, Akinobu Mita wrote:
> As a preparation for providing little-endian bitops for all architectures,
> This removes generic_ prefix from little-endian bitops function names
> in asm-generic/bitops/le.h.
> 
> s/generic_find_next_le_bit/find_next_le_bit/
> s/generic_find_next_zero_le_bit/find_next_zero_le_bit/
> s/generic_find_first_zero_le_bit/find_first_zero_le_bit/
> s/generic___test_and_set_le_bit/__test_and_set_le_bit/
> s/generic___test_and_clear_le_bit/__test_and_clear_le_bit/
> s/generic_test_le_bit/test_le_bit/
> s/generic___set_le_bit/__set_le_bit/
> s/generic___clear_le_bit/__clear_le_bit/
> s/generic_test_and_set_le_bit/test_and_set_le_bit/
> s/generic_test_and_clear_le_bit/test_and_clear_le_bit/
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Roman Zippel <zippel@linux-m68k.org>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Andy Grover <andy.grover@oracle.com>
> Cc: rds-devel@oss.oracle.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: Avi Kivity <avi@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: kvm@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
