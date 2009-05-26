Return-Path: <albert_herranz@yahoo.es>
Received: from web28314.mail.ukl.yahoo.com (web28314.mail.ukl.yahoo.com
	[87.248.110.133]) by ozlabs.org (Postfix) with SMTP id 6BCA2DE00D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 03:13:27 +1000 (EST)
Message-ID: <165800.5673.qm@web28314.mail.ukl.yahoo.com>
Date: Tue, 26 May 2009 17:13:24 +0000 (GMT)
From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Kumar Gala <galak@gate.crashing.org>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--- El lun, 25/5/09, Benjamin Herrenschmidt <benh@kernel.crashing.org> escr=
ibi=F3:=0A=0A> (Please, Kumar, have a good look,=0A> especially my change t=
o FIXMAP_TOP,=0A> was there any reason it wasn't a constant in the first=0A=
> place ?)=0A> =0A> This is going to .30 if nobody hollers. I've done some=
=0A> testing here=0A> and it seems to be fine, but more eyes at this stage =
are=0A> much welcome.=0A=0ATested-by: Albert Herranz <albert_herranz@yahoo.=
es>=0A=0ABoots fine and works on the Nintendo Wii.=0A=0AThanks,=0AAlbert=0A=
=0A=0A=0A=0A      
