Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC328DDE1B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 15:07:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18939.54528.381551.291247@cargo.ozlabs.ibm.com>
Date: Sat, 2 May 2009 15:07:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] windfarm: Convert to a new-style i2c drivers
In-Reply-To: <20090416185615.2f7914ca@hyperion.delvare>
References: <20090416185615.2f7914ca@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean Delvare writes:

> The legacy i2c binding model is going away soon, so convert the
> macintosh windfarm drivers to the new model or they will break.

All works OK on my quad G5 (PowerMac11,2).

Tested-by: Paul Mackerras <paulus@samba.org>

Paul.
