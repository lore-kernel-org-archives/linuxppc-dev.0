Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B7991A0BDC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Nov 2014 02:40:28 +1100 (AEDT)
Message-ID: <54789767.1080803@suse.cz>
Date: Fri, 28 Nov 2014 16:40:23 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: Fix make help-<board series> on powerpc
References: <1417179145-30789-1-git-send-email-mmarek@suse.cz>
In-Reply-To: <1417179145-30789-1-git-send-email-mmarek@suse.cz>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014-11-28 13:52, Michal Marek wrote:
> make ARCH=powerpc help-<board series> should not require a cofigured
> source tree. Also, sort the boards in the output.

I added this to kbuild.git#kbuild.

Michal
