Reply-To: "Todd Inglett" <tinglett@vnet.ibm.com>
Message-Id: <3A018ED0.AEAA1B40@vnet.ibm.com>
Date: Thu, 02 Nov 2000 09:57:04 -0600
From: Todd Inglett <tinglett@vnet.ibm.com>
Mime-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Yet another RS6k whipped!
References: <Pine.HPX.4.10.10011021136540.15431-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:

> Ok, there were a few bugs with Openpic on PreP: some functions were marked
> __chrp while openpic support is a completely orthogonal issue. Yours seems
> to work, however, which source tree are you using ?  (I'm still basing
> everything on kernel.org).

I may still have trouble here.  My code was based on a test8 kernel that
Tom snagged.  I hope I can reproduce it in test10 :).

> Besides this, it's fairly close to what I do on my MVME boxes: the
> firmware puts them in PreP mode and I reorganize them as CHRP. This forces
> me to reorganize all the PCI space (but the code has not been with bridges
> and will probably fail). You have open firmware, which is hopefully more
> flexible than PPCBUG which I have to use.

This is exactly what I want to do.  Any big pitfalls you can recall?
Guess I need to have a look at your patch.  I'm assuming you have a
Grackle.

--
-todd

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
