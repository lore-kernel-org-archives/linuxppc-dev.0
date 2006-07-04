Return-Path: <davej@redhat.com>
Date: Tue, 4 Jul 2006 15:00:54 -0400
From: Dave Jones <davej@redhat.com>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 13/20] [powerpc,
	video & agp] Constify & voidify get_property()
Message-ID: <20060704190054.GA20952@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, davej@codemonkey.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 04, 2006 at 04:47:56PM +1000, Jeremy Kerr wrote:
 > Now that get_property() returns a void *, there's no need to cast its
 > return value. Also, treat the return value as const, so we can
 > constify get_property later.
 > 
 > powerpc-specific video & agp driver changes.
 > 
 > Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Signed-off-by: Dave Jones <davej@redhat.com>

I assume this stuff is going in through the ppc tree?
Holler if not, and I'll push it through agpgart.git

Thanks,

		Dave

-- 
http://www.codemonkey.org.uk
