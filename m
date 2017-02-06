Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHK5Z06DGzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 07:37:06 +1100 (AEDT)
In-Reply-To: <20161206062800.21800-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kernel-hardening@lists.openwall.com,
 keescook@chromium.org, re.emese@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: pageexec@freemail.hu, spender@grsecurity.net, linux-kernel@vger.kernel.org,
 mmarek@suse.com, linux-kbuild@vger.kernel.org
Subject: Re: [1/3] gcc-plugins: fix definition of DISABLE_LATENT_ENTROPY_PLUGIN
Message-Id: <3vHK5Y5hnJz9s7G@ozlabs.org>
Date: Tue,  7 Feb 2017 07:37:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-06 at 06:27:58 UTC, Andrew Donnellan wrote:
> The variable DISABLE_LATENT_ENTROPY_PLUGIN is defined when
> CONFIG_PAX_LATENT_ENTROPY is set. This is leftover from the original PaX
> version of the plugin code and doesn't actually exist. Change the condition
> to depend on CONFIG_GCC_PLUGIN_LATENT_ENTROPY instead.
> 
> Fixes: 38addce8b600 ("gcc-plugins: Add latent_entropy plugin")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7b4010edff09929c253e6626ab19ca

cheers
