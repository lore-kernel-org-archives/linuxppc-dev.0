Date: Tue, 14 Sep 1999 16:58:03 +1000
Message-Id: <199909140658.QAA08107@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: ranga@CSUA.Berkeley.EDU
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199909100518.WAA05129@soda.CSUA.Berkeley.EDU> (message from
	Sriranga Veeraraghavan on Thu, 09 Sep 1999 22:18:09 -0700)
Subject: Re: note about compiling SMP kernels
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <199909100518.WAA05129@soda.CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU> wrote:

> Is the correct procedure still:
> 
> cd /usr/src/linux
> make mrproper
> make pmac_config
> make menuconfig (or whatever you please)
> make dep
> make clean
> gmake -j 3 vmlinux 

That would be fine (but isn't your make == gmake anyway?).  I don't do
the make mrproper myself very often since that deletes your .config, I
tend to do make oldconfig; make clean; make dep; make vmlinux modules
(with a -j if you like).

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
