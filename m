From: phandel@cise.ufl.edu
Date: Mon, 10 Jan 2000 19:11:16 -0500 (EST)
To: jlquinn@us.ibm.com
cc: toa@pop.agri.ch, Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.39-pre2 boots
In-Reply-To: <85256862.00703603.00@D51MTA03.pok.ibm.com>
Message-ID: <Pine.LNX.4.10.10001101834260.2627-100000@PetesBox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Jan 2000 jlquinn@us.ibm.com wrote:

> Did stock 2.3.38 build for you?  I still can't compile it.  There is still
> an error due to irq_offset in arch/ppc/kernel/open_pic.c.  I also get an
> error in (I think) pmac_nvram.c.  Sorry, didn't write it down.

Paul's 2.3.38 works fine, although there are some strange things to watch
out for (like mediabay in the swim3 floppy drive code).  With PowerMac
floppy support off it compiled fine.

rsync -auvz linuxcare.com.au::linux-pmac-devel /usr/src/linux-2.3-devel

Voodoo3 support seems pretty good in Paul's 2.3.38, although there are
major endian issues in text mode, and minor ones in X mode (using Kostas'
3.9.16).


Thanks,
Peter

-- 
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
