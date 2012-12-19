Return-Path: <swarren@wwwdotorg.org>
Message-ID: <50D1EA28.2000807@wwwdotorg.org>
Date: Wed, 19 Dec 2012 09:24:08 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: Fix export of of_find_matching_node_and_match()
References: <1355914716-19469-1-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1355914716-19469-1-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Warren <swarren@nvidia.com>, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2012 03:58 AM, Grant Likely wrote:
> Commit 50c8af4cf9, "of: introduce for_each_matching_node_and_match()"
> renamed of_find_matching_node() to of_find_matching_node_and_match() and
> created a new static inline of_find_matching_node() wrapper around the
> new name. However, the change neglected to change the EXPORT_SYMBOL()
> reference causing build errors for modules.
> 
> This patch fixes the EXPORT_SYMBOL() statement. Discovered on a PowerPC
> Efika build with the mpc52xx_uart driver being built as a module.

Oops. The patch is obviously correct,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

I guess none of the ARM defconfigs enable any module that uses this,
since I have built all of them multiple times recently:-(
