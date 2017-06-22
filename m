Return-Path: <robherring2@gmail.com>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtmrq6V5KzDqjQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 02:15:23 +1000 (AEST)
Received: by mail-pg0-f66.google.com with SMTP id j186so3031634pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 09:15:23 -0700 (PDT)
Date: Thu, 22 Jun 2017 11:15:19 -0500
From: Rob Herring <robh@kernel.org>
To: frowand.list@gmail.com
Cc: afaerber@suse.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Documentation: remove overlay-notes reference to
 non-existent file
Message-ID: <20170622161519.wmpqrdszgwen6nsl@rob-hp-laptop>
References: <1497998453-1585-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497998453-1585-1-git-send-email-frowand.list@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2017 at 03:40:53PM -0700, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> File dt-object-internal.txt does not exist.  Remove a reference to it
> and fix up tags for references to other files.
> 
> Reported-by: afaerber@suse.de
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  Documentation/devicetree/overlay-notes.txt | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied.
