Subject: RE: U-Boot and kernel 2.6
From: David Woodhouse <dwmw2@infradead.org>
To: Meriin Michael-BMM063 <Meriin@motorola.com>
Cc: "'Ricardo DIz'" <rdiz@alumni.deec.uc.pt>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <0F48024310E5D6118D200002B3A440DB08B07A3D@zil01exm08.mcil.comm.mot.com>
References: 
	 <0F48024310E5D6118D200002B3A440DB08B07A3D@zil01exm08.mcil.comm.mot.com>
Content-Type: text/plain
Message-Id: <1086950206.15845.1268.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Fri, 11 Jun 2004 11:36:47 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-06-10 at 09:45 +0300, Meriin Michael-BMM063 wrote:
> Check the bd_t definition, it MUST be the same in u-boot and Linux platform definition.
> bd_t in Linux is defined in ppcboot.h

We really need to throw this crap away and start using structured tags
like ARM does.

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
