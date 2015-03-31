Return-Path: <jirislaby@gmail.com>
Received: from mail-wg0-x236.google.com (mail-wg0-x236.google.com
 [IPv6:2a00:1450:400c:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B08881A0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 20:33:30 +1100 (AEDT)
Received: by wgra20 with SMTP id a20so12304514wgr.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 02:33:25 -0700 (PDT)
Sender: Jiri Slaby <jirislaby@gmail.com>
Message-ID: <551A69E3.5070108@suse.cz>
Date: Tue, 31 Mar 2015 11:33:23 +0200
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, stable@vger.kernel.org
Subject: Re: stable: Please include commit bb344ca5b90 ("powerpc/mpc85xx:
 Add ranges to etsec2 nodes")
References: <20150326211427.GA20872@home.buserror.net>
In-Reply-To: <20150326211427.GA20872@home.buserror.net>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/26/2015, 10:14 PM, Scott Wood wrote:
> Commit bb344ca5b90df6 ("powerpc/mpc85xx: Add ranges to etsec2 nodes")
> fixes a bug that was exposed by commit 746c9e9f92dd ("of/base: Fix
> PowerPC address parsing hack").  The latter commit was applied to stable
> trees, so the former should be as well.

Applied to 3.12. Thanks.

-- 
js
suse labs
