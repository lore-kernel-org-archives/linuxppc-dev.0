Date: Mon, 22 Jan 2001 18:59:52 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: michdaen@iiic.ethz.ch
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeff Hartmann <jhartmann@valinux.com>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6C00E4.53D3356D@relog.ch>
Message-ID: <Pine.GSO.4.10.10101221854100.18061-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Michel Dänzer wrote:

> > [drm] drm_sg_alloc
> > i: ca292000
> > pgd: c014dca0
> > pmd: c014dca0
> > pte: 00000a48
> > Oops: kernel access of bad area, sig: 11
>
> Looking at pgd/pmd, pte seems fishy for a pointer. Any reason why this code
> shouldn't work on PPC?

There is no pte table and so there is nothing mapped at that address, you
can use (pgd|pmd|pte)_present() to test for that.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
