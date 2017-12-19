Return-Path: <martin.petersen@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z14zz1gm0zDsRm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 15:43:58 +1100 (AEDT)
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, acpi4asus-user@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-xfs@vger.kernel.org, linux-audit@redhat.com,
 alsa-devel@alsa-project.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [trivial PATCH] treewide: Align function definition open/close
 braces
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1513556924.31581.51.camel@perches.com>
Date: Mon, 18 Dec 2017 22:31:06 -0500
In-Reply-To: <1513556924.31581.51.camel@perches.com> (Joe Perches's message of
 "Sun, 17 Dec 2017 16:28:44 -0800")
Message-ID: <yq1shc7jsw5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Joe,

> Some functions definitions have either the initial open brace and/or
> the closing brace outside of column 1.
>
> Move those braces to column 1.

SCSI bits look OK.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
