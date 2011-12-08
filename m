Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5511100811
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 18:23:43 +1100 (EST)
Subject: Re: [PATCH] sbc834x: put full compat string in board match check
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1323103267-22786-1-git-send-email-paul.gortmaker@windriver.com>
Date: Thu, 8 Dec 2011 01:23:54 -0600
Message-Id: <75AE1E90-3EC9-408D-AAAB-0577138962CF@kernel.crashing.org>
References: <1323103267-22786-1-git-send-email-paul.gortmaker@windriver.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 5, 2011, at 10:41 AM, Paul Gortmaker wrote:

> The commit 883c2cfc8bcc0fd00c5d9f596fb8870f481b5bda:
> 
> "fix of_flat_dt_is_compatible() to match the full compatible string"
> 
> causes silent boot death on the sbc8349 board because it was
> just looking for 8349 and not 8349E -- as originally there
> were non-E (no SEC/encryption) chips available.  Just add the
> E to the board detection string since all boards I've seen
> were manufactured with the E versions.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

applied to merge

- k
