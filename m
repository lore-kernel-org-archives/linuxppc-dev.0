Date: Tue, 27 Mar 2001 15:03:21 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aci7xxxx build fails 2.4.3-p{3..8}
In-Reply-To: <20010327202214.1A68ADBA52@atlas.valhalla.net>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010327150111.85236C-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Mar 2001, Iain Sandoe wrote:

> `/usr/src/linuxppc_2_4/drivers/scsi/aic7xxx/aicasm'
> gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm

Missing a "-I."?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
