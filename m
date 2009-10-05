Return-Path: <mike@terascala.com>
Received: from hermes.terascala.com (terascala.com [75.147.14.129])
	by ozlabs.org (Postfix) with ESMTP id 68CE8B7B8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 02:49:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Regression detecting memory size on PPC440EPx
Date: Mon, 5 Oct 2009 11:49:47 -0400
Message-ID: <2C7DE72B9BD00F44BAECA5B0CBB873955CADF4@hermes.terascala.com>
In-Reply-To: <4ACA1475.1000101@ru.mvista.com>
From: "Mike Nuss" <mike@terascala.com>
To: "Valentine" <vbarshak@ru.mvista.com>,
	"Mikhail Zolotaryov" <lebon@lebon.org.ua>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Valentine wrote:
> AFAIK, u-boot just writes pre-defined values to the memory controller
> registers. It doesn't do any chiptype/memsize detection. These values
> are set for Sequoia and may not suite your board. So you probably need
> to adjust the u-boot to make linux detect the memory size correctly.
>=20
> Thanks,
> Val.

In old versions of U-Boot that was true. Now there is definitely code
that reads the SPD EEPROM and sets up the Denali controller
appropriately.

There could be some hardcoded value being written to the registers that
is incorrect for the kernel - in fact that is my suspicion - but the
values U-Boot itself is using for the size calculation must be correct.

Mike

PS: Is top posting customary on this list?  I'm used to bottom posting;
let me know if I'm doing it wrong.
