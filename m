Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 07CB8DDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 22:56:10 +1100 (EST)
Message-ID: <4948E89A.7080703@scram.de>
Date: Wed, 17 Dec 2008 12:55:06 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: Please pull bjdoo ks' i2c-fixes
References: <E1LChEf-0000Ts-53@teyla.home.fluff.org>
In-Reply-To: <E1LChEf-0000Ts-53@teyla.home.fluff.org>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Mike Ditto <mditto@consentry.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-i2c@vger.kernel.org, khali@linux-fr.org,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

> Mike Ditto (1):
>       i2c-cpm: Detect and report NAK right away instead of timing out

Could you also have a look at http://patchwork.ozlabs.org/patch/7452/ ?
(Discussion at http://patchwork.ozlabs.org/patch/6666/ )

IIRC, Kumar prefers to push this via your tree.

Thanks,
Jochen
