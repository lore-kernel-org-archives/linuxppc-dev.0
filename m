From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: <fabidi@ultsol.com>
Subject: Re: BDI kernel debug
Date: Thu, 8 Jul 2004 16:03:16 +0200
Cc: "'PPC_LINUX'" <linuxppc-embedded@lists.linuxppc.org>
References: <81C69D96BDD30640952C7A404004AA2501AA21@h0007e95d9fa7.ne.client2.attbi.com>
In-Reply-To: <81C69D96BDD30640952C7A404004AA2501AA21@h0007e95d9fa7.ne.client2.attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200407081603.16466.Schramel.Linux@go.bartec.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Fahd,

thanks for the help


> Then check /linuxroot/arch/ppc/kernel/head.S, do a search for
> CONFIG_BDI_SWITCH. Make sure the option is valid and that the pgtables do
> indeed get updated. If the switch is valid then probably something else is
> wrong.
>
> Check to make sure that the PGTABLE base is at 0x000000f0 and that is what
> you have set it to in your BDI config file. The BDI config file has to
> match what you have in head.S.

Adding PTBASE 0x000000f0 to the  [TARGET] section in the bdi config file works very well.

Thanks
Marco




---------
Marco Schramel
R&D
Bartec GmbH
Schulstr. 30
94239 Gotteszell, Germany
www.bartec.de
Marco.Schramel@go.bartec.de
Phone:  +49 (0)9929/301332
Fax:    +49 (0)9929/301112


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
