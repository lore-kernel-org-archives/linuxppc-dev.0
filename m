Date: Thu, 16 Oct 2003 09:37:46 -0500
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Ken Offer <koffer@arlut.utexas.edu>
In-Reply-To: <1066231321.646.58.camel@gaston>
Message-Id: <4F1C744C-FFE6-11D7-9F9F-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday, October 15, 2003, at 10:22  AM, Benjamin Herrenschmidt
wrote:

> On Wed, 2003-10-15 at 17:09, Ken Offer wrote:
>> On Wednesday, October 15, 2003, at 03:19  AM, Benjamin Herrenschmidt
>> wrote:
>
>> Hi Ben,
>>
>> Below are the warnings I get with "make modules_install" and your
>> 2.6.0-test7 kernel using the pmac_defconfig config file with pcnet32
>> turned off.  This was compiled with gcc 3.2.2.
>
> Something is wrong on your side, either a build system,
> incorrect module tools or whatever...

I suppose its possible.  I'm not sure what would be wrong, unless the
2.6 kernel doesn't like gcc 3.2.2.

> Did you install the module-init-tools ? Those replace modutils for
> 2.6 (actually, you can have both installed, the correct ones will
> be picked up automatically)

I have not.  I wasn't aware of "module-init-tools".  It shouldn't be
necessary to build and link the 2.6 kernel, should it?

By the way, I went ahead and installed the 2.6 kernel it built (I
figured it would be missing some modules, but what the heck...)  X11
appeared to work with the radeonfb driver.  KDE asked me for the time,
date, etc.  However, just after I attempted to log in KDE croaked and
locked up the system while "initializing services".  Since it was a
hard-freeze and I didn't get a kernel opps, I have no feedback other
than this.  I'm hoping it has nothing to do with the radeonfb driver.

Right now I'm attempting to back-port the 2.6 radeonfb driver to the
2.4 kernel myself.  I don't know the driver as well as you Ben, but I
need to make some sort of progress.  I'm betting the 2.6 kernel is
probably too bleeding-edge right now for a deliverable system. :)

+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
