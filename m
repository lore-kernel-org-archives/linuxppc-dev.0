Return-Path: <jdl@jdl.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] dtc: give advance warning that "-S" is going away. 
In-reply-to: <1217426356-1248-1-git-send-email-paul.gortmaker@windriver.com> 
References: <E1KOBwm-0002vc-CT@jdl.com>
	<1217426356-1248-1-git-send-email-paul.gortmaker@windriver.com>
Date: Thu, 31 Jul 2008 10:43:41 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KOaJZ-0006NA-Sl@jdl.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The "-S" option allowed the specification of a minimum size for
> the blob, however the main reason for caring about the size is
> so there is enough padding to add a chosen node by u-boot or
> whoever.  In which case, folks don't really care about the absolute
> size, but rather the size of the padding added for this -- which
> is what the "-p" option does.  Having the "-S" just confuses people.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Applied.

jdl
