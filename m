Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0DDDF2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 07:09:57 +1100 (EST)
Subject: Re: [PATCH v2 1/1] powerpc/85xx: Board support for ppa8548
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <510FD412.4000505@calxeda.com>
Date: Tue, 12 Feb 2013 14:09:48 -0600
Message-Id: <8D4EF5B0-BEC6-4114-88CF-166EB3A70A53@kernel.crashing.org>
References: <1359920347-15340-1-git-send-email-stef.van.os@prodrive.nl>
 <510FD412.4000505@calxeda.com>
To: Timur Tabi <timur.tabi@calxeda.com>
Cc: Scott Wood <scottwood@freescale.com>, Stef van Os <stef.van.os@prodrive.nl>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 4, 2013, at 9:30 AM, Timur Tabi wrote:

> On 02/03/2013 01:39 PM, Stef van Os wrote:
>=20
>> +	pci0: pci@fe0008000 {
>> +		status =3D "disabled";
>> +	};
>> +
>> +	pci1: pci@fe0009000 {
>> +		status =3D "disabled";
>> +	};
>> +
>> +	pci2: pcie@fe000a000 {
>> +		status =3D "disabled";
>> +	};
>=20
> I was hoping you'd follow my example and include a comment indicating =
why the PCI devices are all disabled.
>=20
>> +static void ppa8548_show_cpuinfo(struct seq_file *m)
>> +{
>> +	uint svid, phid1;
>=20
> Please don't used unsized integers for hardware registers.
>=20
> 	uint32_t svid, phid1;


Stef,

If you'd like this included for 3.9, please make the minor updates.

thanks

- k=
