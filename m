Date: Wed, 13 Oct 1999 11:38:22 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: How to get latest vger 2.2 sources???
In-Reply-To: <199910130839.KAA04644@macintoy.masq.in-berlin.de>
Message-ID: <Pine.GSO.4.10.9910131136470.21530-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Oct 1999, Gerd Knorr wrote:
> In lists.linuxppc.dev, you wrote:
> > On Tue, 12 Oct 1999, Claude Robitaille wrote:
> > > I am the one who just asked how to get linux from on.openprojects.net
> > > 
> > > To get 2.2, the answer I got was:
> > > 
> > > start downloading 2.3
> > > then stop it using ctrl-C
> > > cvs update -dP -rlinux_2_2
> > 
> > Doesn't `cvs -z3 checkout -rlinux_2_2 linux' work?
> 
> Are there patches vanilla-2.[23].x => CVS tree available somewhere ?

I don't know. You can always ask me to generate them.

Unfortunately vger is still at 2.3.18, except for the fbdev stuff, which is at
the 2.3.{21,22} level :-)

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248632 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
