Date: Tue, 27 Mar 2001 17:22:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: aci7xxxx build fails 2.4.3-p{3..8}
Message-ID: <20010327172212.H29571@opus.bloom.county>
References: <20010327202214.1A68ADBA52@atlas.valhalla.net> <Pine.A41.3.96LJ1.1b7.1010327150111.85236C-100000@unlserve.unl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.A41.3.96LJ1.1b7.1010327150111.85236C-100000@unlserve.unl.edu>; from toe@unlserve.unl.edu on Tue, Mar 27, 2001 at 03:03:21PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 27, 2001 at 03:03:21PM -0600, Takashi Oe wrote:
>
> On Tue, 27 Mar 2001, Iain Sandoe wrote:
>
> > `/usr/src/linuxppc_2_4/drivers/scsi/aic7xxx/aicasm'
> > gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
> > aicasm_symbol.c -o aicasm
>
> Missing a "-I."?

Yes.  I was wondering how the hell this worked on other arches..
Hopefully the next preN will have the latest driver..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
