Date: Tue, 30 Nov 1999 14:39:01 -0600
From: Shaw Terwilliger <sterwill@io.nu>
To: Paul Mackerras <paulus@linuxcare.com>
Cc: Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.30-pre3
Message-ID: <19991130143901.A30660@io.nu>
References: <38423714.D5136535@wanadoo.fr> <99120107124704.02316@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99120107124704.02316@argo.linuxcare.com.au>; from paulus@linuxcare.com on Wed, Dec 01, 1999 at 07:07:06AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
> This is (partly at least) my fault.  I upgraded to 2.3.30-pre3 (a merge of
> my tree and Cort's), found it didn't work, and reverted the devel tree to
> 2.3.29, which does work just fine for me.

Well, I was just using the old rsync repository at samba.anu.edu.au, not
at linuxcare.com.au.  However, the keyboard.h file had been that
way for a few weeks, probably unnoticed while everyone used the newer
repository.  I did a little patching and that kernel's running fine
on my laptop.

I would ask that perhaps samba.anu.edu.au::linux-pmac-[stable/devel]
be turned off (or print a nice MOTD with the new location) since there 
are countless web pages out there that still point to it.

> maybe I was updating it as he was fetching it or something.  I have
> changed the ifdef in chipsfb.c as Shaw suggested.

It looked right to me, but I didn't have a chips device to test it with.
Just seemed like an unnecessary test and kept me (and presumably others)
from compiling it.

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
