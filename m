Return-Path: <ayoub_zaki@yahoo.fr>
Date: Mon, 15 Sep 2008 11:26:19 +0000 (GMT)
From: ayoub zaki <ayoub_zaki@yahoo.fr>
Subject: Re: PCI Post Boot scan
To: Christian Krafft <parabelboi@bopserverein.de>
In-Reply-To: <20080915125627.5b3465ae@schleppi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <550493.22907.qm@web26605.mail.ukl.yahoo.com>
Cc: Linuxppc-dev@ozlabs.org
Reply-To: ayoub_zaki@yahoo.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Christian,


Unfortunately lspci -M is not showing my device.


Best regards,

Ayoub Zaki


--- En date de : Lun 15.9.08, Christian Krafft <parabelboi@bopserverein.de>=
 a =E9crit :

> De: Christian Krafft <parabelboi@bopserverein.de>
> Objet: Re: PCI Post Boot scan
> =C0: ayoub_zaki@yahoo.fr
> Cc: Linuxppc-dev@ozlabs.org
> Date: Lundi 15 Septembre 2008, 12h56
> Hi Ayoub,
>=20
> On Mon, 15 Sep 2008 09:13:23 +0000 (GMT)
> ayoub zaki <ayoub_zaki@yahoo.fr> wrote:
>=20
> >=20
> > Hi all,
> >=20
> > I'm working on a mpc8572ds based board from
> freescale.
> >=20
> > I have an onboard FPGA (PCI express) that I want to
> configure from the userspace application with the
> corresponding "firmware".=20
> >=20
> > Only after a configuration that the FPGA shows its PCI
> nature.
> >=20
> > the problem is that linux has no way to detect the PCI
> device unless I reboot my board.
> >=20
> > fakephp wouldn't help scince my device is not
> configured at the boot time.
> >=20
> > Is there any way to do it so ?
> >=20
> > Is it possible to re-initialize the whole pci stack
> again ?
>=20
> Does "lspci -M" do the trick ?
>=20
> >=20
> > Thanks for any kind help
> >=20
> > Ayoub Zaki
> >=20
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
>=20
> --=20
> Cheers,
> ck
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev=0A=0A=0A      
