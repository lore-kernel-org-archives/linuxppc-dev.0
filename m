Date: Thu, 7 Oct 1999 10:55:23 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: pac1@tiac.net, linuxppc-dev@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com
Subject: Re: Who develops and supports the XF68_FBDev X server?
In-Reply-To: <199910070840.KAA02341@simul.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.9910071054070.24804-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 7 Oct 1999, Michael Schmitz wrote:
> > > Who does support XF68_FBDev server?
> > 
> > Me (more or less).
> 
> That's what I thought - but I had the strange notion the fbdev server
> was supported by xfree? 

I hope it will. For 4.0, that sounds logical, since `fbdev' will be just
another probe type like `vga'.

I guess they put the `unsupported' in the FAQ to avoid being flooded with
people trying to change video modes with vesafb. BTW, the same `support
problem' applies to offb on PPC :-)

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
