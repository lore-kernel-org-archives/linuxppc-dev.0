Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Message-ID: <42B1EBFC.4020105@smiths-aerospace.com>
Date: Thu, 16 Jun 2005 17:15:40 -0400
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
References: <20050616070816.GE31347@localhost.localdomain>
	<1118954956.25372.71.camel@cashmere.sps.mot.com>
In-Reply-To: <1118954956.25372.71.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>,
	u-boot-users <u-boot-users@lists.sourceforge.net>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: More dtc changes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> On Thu, 2005-06-16 at 02:08, David Gibson wrote:
> 
>>I now have a git tree for the device tree compiler up at
>>http://www.ozlabs.org/~dgibson/dtc/dtc.git
> 
> 
> Very Cool!
> 
> And, um, rats.  So, I'm the victim of an aggressive
> and anti-social IT Firewall poo-poolicy....  Or maybe I
> am just being dumb and haven't Googled up the Right Magic.
> 
> Is there a way to set an HTTP Proxy definition, flag,
> parameter, environment variable, or other doo-dad that
> will help me cg-pull/git-http-pull through my firewall?
> 
> Alternatively, any chance we can convert it to, or add,
> an rsync tree?
> 
> 
>>There's a tarball release as well
>>http://www.ozlabs.org/~dgibson/dtc/dtc.tar.gz
> 
> 
> If not, I'll have to be doing the tarball thing...
> 
> Thanks,
> jdl

It ain't efficient and it is pull-only, but it works:

$ mkdir test

$ cd test
test$ ll
total 0

$ cg-clone http://www.ozlabs.org/~dgibson/dtc/dtc.git
defaulting to local storage area
17:13:12 
URL:http://www.ozlabs.org/%7Edgibson/dtc/dtc.git/refs/heads/master 
[41/41] -> "refs/heads/origin" [1]
progress: 40 objects, 59841 bytes

FINISHED --17:13:25--
Downloaded: 951 bytes in 1 files
New branch: 81f2e89c7551ef44a6203ab1cbb8228d09202572
Cloned (origin http://www.ozlabs.org/~dgibson/dtc/dtc.git available as 
branch "origin")
Cloned to dtc/ (origin http://www.ozlabs.org/~dgibson/dtc/dtc.git 
available as branch "origin")

$ ll dtc/
total 116
-rw-r--r--  1 vanbaren cideas   446 2005-06-16 17:13 comment-test.dts
-rw-r--r--  1 vanbaren cideas 17992 2005-06-16 17:13 COPYING
-rw-r--r--  1 vanbaren cideas  4776 2005-06-16 17:13 data.c
-rw-r--r--  1 vanbaren cideas  4896 2005-06-16 17:13 dtc.c
-rw-r--r--  1 vanbaren cideas  4704 2005-06-16 17:13 dtc.h
-rw-r--r--  1 vanbaren cideas  2989 2005-06-16 17:13 dtc-lexer.l
-rw-r--r--  1 vanbaren cideas  2890 2005-06-16 17:13 dtc-parser.y
-rw-r--r--  1 vanbaren cideas 19400 2005-06-16 17:13 flattree.c
-rw-r--r--  1 vanbaren cideas  2324 2005-06-16 17:13 fstree.c
-rw-r--r--  1 vanbaren cideas 15506 2005-06-16 17:13 livetree.c
-rw-r--r--  1 vanbaren cideas   559 2005-06-16 17:13 Makefile
-rw-r--r--  1 vanbaren cideas   707 2005-06-16 17:13 test.dts
drwxr-xr-x  2 vanbaren cideas  4096 2005-06-16 17:13 tests
-rw-r--r--  1 vanbaren cideas   566 2005-06-16 17:13 TODO
-rw-r--r--  1 vanbaren cideas  3000 2005-06-16 17:13 treesource.c

$ du -s *
1368    dtc

gvb
