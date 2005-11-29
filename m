Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17291.57189.117039.189874@cargo.ozlabs.ibm.com>
Date: Tue, 29 Nov 2005 15:56:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <438B238F.9070804@ru.mvista.com>
References: <438B238F.9070804@ru.mvista.com>
Cc: linuxppc-devel list <linuxppc-dev@ozlabs.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32 8xx: Added setbitsXX/clrbitsXX macro for
 read-modify-write operations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vitaly Bordug writes:

> This adds setbitsXX/clrbitsXX macro for read-modify-write operations
> and converts the 8xx core and drivers to use it.

Your mailer has munged the whitespace in the patch, unfortunately.

> +	clrbits32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr,(1 << cpm_vec));

This needs a space after the comma.

Regards,
Paul.
