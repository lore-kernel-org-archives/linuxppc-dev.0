From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <66CE949D18BCB249ABE8D9AF48C4F1CE7776DC@helios.gnv.tcc.thomson-csf.com>
To: wolfgang.grandegger@bluewin.ch,
	Christophe.LINDHEIMER@fr.thalesgroup.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Driver with floats.
Date: Thu, 25 Sep 2003 15:23:55 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok

Thank you, it seems it compiles much better now !

Regards

Chris


> -----Message d'origine-----
> De : Wolfgang Grandegger [mailto:wolfgang.grandegger@bluewin.ch]
> Envoye : jeudi 25 septembre 2003 11:07
> A : Christophe.LINDHEIMER@fr.thalesgroup.com
> Cc : linuxppc-embedded@lists.linuxppc.org
> Objet : Re: Kernel Driver with floats.
>
>
> On 09/25/2003 10:45 AM Christophe.LINDHEIMER@fr.thalesgroup.com wrote:
> > Hi.
> >
> > I would like to know if it is possible to use floats in a
> kernel driver.
> > I use a MPC860.
> > I get unresolved symbols with the standard makefile.
> > Are there special options to use ?
> > Any lib to add ?
>
> We have a demo module for RTAI using soft-floats on MPC 8xx at
> ftp://ftp.denx.de/pub/RTAI/contrib/fp_ppc_8xx.tar.bz2. There
> is a README
> inside. But be aware that soft-float on the 860 is very slow,
> especially
> when you do complex FP math like sin() etc.
>
> Wolfgang.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
