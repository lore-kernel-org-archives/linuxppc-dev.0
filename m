Message-ID: <39379C61.E33FF001@pop.agri.ch>
Date: Fri, 02 Jun 2000 13:37:07 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: 7200 & bitkeeper/linuxcare devel?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
has anyone gotten a bitkeeper 2.4.0test1-ac7 or a linuxcare 2.3.99p9 to
boot under a 7200?
I try this with absolutley no luck. The last linuxcare was a 2.3.99p6
which I got to boot. Unfortunately I missed the updates between p6 and
p9. Both kernels run under a wallstreet. I use BootX 1.2.2 since I'm not
able to get quik working :-(.

The only thing I see on the screen:
booting...
setup_arch: enter
setup_arch: bootmem
arch: exit

I played with bk sccstool to track down the relevant changes, but it
seems that I have to learn a lot with this bk tool. Also, there are many
changes from 2.3.99p6 until 2.4.0test1-ac7 so it's really difficult to
find out.

Any hints would be great.

Thanks

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
