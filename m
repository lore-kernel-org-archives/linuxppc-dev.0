Date: Tue, 26 Oct 1999 10:12:29 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: luther@dpt-info.u-strasbg.fr
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org,
        jmb@montana.edu
Subject: Re: iBook/UMA pre3
In-Reply-To: <19991026095628.A18917@maxime.u-strasbg.fr>
Message-ID: <Pine.LNX.4.10.9910261012010.1206-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Oct 1999, Sven LUTHER wrote:

> 
> On Mon, Oct 25, 1999 at 10:36:13PM +0200, Benjamin Herrenschmidt wrote:
> > 
> > I updated the patches and kernel to a new version. PCI config is fully
> > working now, USB works too. I'n now running MacOS under mac-on-linux (the
> > new version that doesn't require you to patch the kernel) on linux on the
> > iBook ;)
> 
> Is any iof the scsi on USB controllers supported by linux ? 
> 
> Is some one working on this, is it difficult to do ?

They supposedly work, tho I'm not sure if anyone has tried it w/ an OHCI
controller.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
