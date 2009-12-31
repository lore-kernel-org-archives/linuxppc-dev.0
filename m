Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id F08A91007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 11:01:56 +1100 (EST)
Received: by yxe8 with SMTP id 8so13124965yxe.17
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Dec 2009 16:01:55 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1262216393.29396.41.camel@localhost.localdomain>
References: <1261446643-21714-1-git-send-email-ptyser@xes-inc.com>
	<1261446643-21714-4-git-send-email-ptyser@xes-inc.com>
	<fa686aa40912301502x48785614ya4dd5c71815a7633@mail.gmail.com>
	<1262216393.29396.41.camel@localhost.localdomain>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 30 Dec 2009 17:01:35 -0700
Message-ID: <fa686aa40912301601s6cd0ec4y85b88976159a36af@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] powerpc: Add support for ram filesystems in FIT
	uImages
To: Peter Tyser <ptyser@xes-inc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: u-boot <u-boot@lists.denx.de>, linuxppc-dev@ozlabs.org,
	linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 30, 2009 at 4:39 PM, Peter Tyser <ptyser@xes-inc.com> wrote:
> Hi Grant,
> I put U-Boot ML on CC.

Thinking further, I do actually have another concern, at least with
regard to the way the current patch set implements things.  Is it
expected or even "recommended" that fit images will *always* contain a
.dtb image?  The current patch only handles the case of a .dtb
embedded inside the fit image.

Personally, I don't get any benefit out of the new image format, so I
haven't spent any time looking at it.  However, I'm concerned about
the drift back towards a different image per target when the move over
the last 4 years has been towards multiplatform kernel images.  I
certainly don't want to encourage embedding the device tree blob into
the kernel image, and I'm not very interested in merging code to do
that into the kernel tree.  If someone really needs to do that for
their particular target, it is certainly easy enough for them to weld
in the .dtb after the fact before transferring the image to the
target, but I want that mode to be the exception, not the rule.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
