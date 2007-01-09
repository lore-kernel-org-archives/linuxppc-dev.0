Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17827.34251.87306.719371@cargo.ozlabs.ibm.com>
Date: Tue, 9 Jan 2007 23:08:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH 3/4] powerpc: Use common 52xx of_platform probe code for
	EFIKA
In-Reply-To: <11677769981995-git-send-email-tnt@246tNt.com>
References: <1167776995690-git-send-email-tnt@246tNt.com>
	<116777699771-git-send-email-tnt@246tNt.com>
	<11677769982640-git-send-email-tnt@246tNt.com>
	<11677769981995-git-send-email-tnt@246tNt.com>
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut writes:

> Now that the device tree has the good properties, we can
> remove all the efika_init code by a single call to common code.

Ummm, but the device tree doesn't have good properties, does it,
without your patch that adds a whole pile of device tree fixups?
I'm reluctant to put that in for 2.6.20 because it's moderately large,
has at least the potential to upset other platforms, and what it fixes
isn't a regression from 2.6.19, and we're already past -rc4.

Your patch 4/4 seems to depend on this one (3/4) so I didn't put it in
for 2.6.20 either.

Paul.
