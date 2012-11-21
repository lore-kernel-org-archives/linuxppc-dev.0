Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EEDFF2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 23:03:02 +1100 (EST)
Date: Wed, 21 Nov 2012 12:00:40 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 298/493] video: remove use of __devinitdata
Message-ID: <20121121120040.GJ3290@n2100.arm.linux.org.uk>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-298-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353349642-3677-298-git-send-email-wfp5p@virginia.edu>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: cbe-oss-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
 Maik Broemme <mbroemme@plusserver.de>, Antonino Daplas <adaplas@gmail.com>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Geoff Levand <geoff@infradead.org>, gregkh@linuxfoundation.org,
 Thomas Winischhofer <thomas@winischhofer.net>, linux-geode@lists.infradead.org,
 Kristoffer Ericson <kristoffer.ericson@gmail.com>,
 Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
 Michal Januszewski <spock@gentoo.org>, Peter Jones <pjones@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-nvidia@lists.surfsouth.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Jaya Kumar <jayalk@intworks.biz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 01:24:07PM -0500, Bill Pemberton wrote:
>  drivers/video/acornfb.c                |  8 +++---
>  drivers/video/cyber2000fb.c            |  2 +-
>  drivers/video/sa1100fb.c               |  2 +-

For these three,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
