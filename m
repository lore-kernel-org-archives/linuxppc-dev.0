Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17242.56232.293762.303684@cargo.ozlabs.ibm.com>
Date: Sun, 23 Oct 2005 10:39:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Rupert Eibauer <rupert@ces.ch>
In-Reply-To: <200510221554.03810.rupert@ces.ch>
References: <200510221554.03810.rupert@ces.ch>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFT] Extended BAT features, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rupert Eibauer writes:

> What this patch actually does:
> - Make CONFIG_PHYS_64BIT selectable for the 6xx family

Why?  What does this gain us?  We still can't use RAM above the 4GB
point AFAICS.

Paul.
