Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E6C3DDF0F
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 13:57:19 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18939.49436.593663.693151@cargo.ozlabs.ibm.com>
Date: Sat, 2 May 2009 13:42:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] therm_adt746x: Convert to a new-style i2c driver
In-Reply-To: <20090416225927.4254efc5@hyperion.delvare>
References: <20090416225927.4254efc5@hyperion.delvare>
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

> The legacy i2c binding model is going away soon, so convert the ppc
> therm_adt746x driver to the new model or it will break.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Seems to work OK on my powerbook (PowerBook5,4).

Tested-by: Paul Mackerras <paulus@samba.org>

Paul.
