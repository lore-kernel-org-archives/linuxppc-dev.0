Date: Thu, 7 Oct 1999 08:46:53 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Patrick Callahan <pac1@tiac.net>
cc: linuxppc-dev@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com
Subject: Re: Who develops and supports the XF68_FBDev X server?
In-Reply-To: <37FB96D5.C9014707@tiac.net>
Message-ID: <Pine.GSO.4.10.9910070846220.24804-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Oct 1999, Patrick Callahan wrote:
> In  http://www.xfree.org/FAQ/#SectionF
> 
> "If you are running a recent 2.1.x version of Linux, you can also use
> the vesafb driver and the XF68_FBDev server. These are not supported by
> XFree86, so don't ask us about any problems you may have using them. "
> 
> Who does support XF68_FBDev server?

Me (more or less).

Note that vesafb works on ia32 only. But on PPC we have lots of real frame
buffer devices.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
