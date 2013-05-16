Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [12.216.194.151])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "usmamail.tilera.com",
 Issuer "Go Daddy Secure Certification Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C17C2C0160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 23:38:58 +1000 (EST)
Message-ID: <5194E021.8080906@tilera.com>
Date: Thu, 16 May 2013 09:33:21 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 08/10] tile: uaccess s/might_sleep/might_fault/
References: <cover.1368702323.git.mst@redhat.com>
 <018bba1e097552bc4054e6d90e3f03e7c9a632bb.1368702323.git.mst@redhat.com>
In-Reply-To: <018bba1e097552bc4054e6d90e3f03e7c9a632bb.1368702323.git.mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/16/2013 7:15 AM, Michael S. Tsirkin wrote:
> The only reason uaccess routines might sleep
> is if they fault. Make this explicit.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/tile/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
