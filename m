Date: Sun, 14 Nov 1999 21:31:26 -0500
From: Michael Meissner <meissner@cygnus.com>
To: Michael Meissner <meissner@cygnus.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux 2.2.13 on an original PowerStack-I
Message-ID: <19991114213126.A19437@tiktok.cygnus.com>
References: <199911100542.AAA08374@tiktok.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199911100542.AAA08374@tiktok.cygnus.com>; from Michael Meissner on Wed, Nov 10, 1999 at 12:42:25AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 10, 1999 at 12:42:25AM -0500, Michael Meissner wrote:
> 
> I have an original PowerStack-I (66 Mhz 603 with no cache) that has
> been sitting idle since about January, and I thought I would turn it
> into a web server.  I did the usual boot with my carefully preserved
> FD_SETUP, base tools, build tools, FD_BOOT diskettes, and set up a R4
> system, and tried to boot with the 2.2.13 kernel I'm running on my
> PowerStack-II (a 'UTAH' 200 Mhz 604e, 512K Cache).  It seemed to fail
> miserably looking for hda/hdb.  Is there a known patch to make the
> older PowerStack-I boot?  I vaguelly recall having this problem except
> reversed in the January time frame (standard kernel would boot on the
> older machine but not boot on the newer machine, but there was a patch
> available to make it boot on the new machine which broke the old
> machine -- evidently that patch went into the tree).  Ideally, I could
> run the same kernel on both machines, but I could live with different
> kernels.

Just in case anybody else has the same problem, I figured out what my problem
is -- I forgot to compile in the NCR53C8XX driver.  I compiled in the SYM53C8XX
driver on the 604e, but the 603 only has a 53c810 onboard.  Whoops.

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
