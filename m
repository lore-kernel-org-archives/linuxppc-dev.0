From: Charles Stevenson <csteven@terraplex.com>
Reply-To: csteven@terraplex.com
To: yellowdog-devel@lists.yellowdoglinux.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Changing default partition type for linux/ppc
Date: Fri, 7 Jul 2000 09:25:50 -0600
Content-Type: text/plain
References: <20000707105915.30418@mailhost.mipsys.com> <3965D59C.BC1BAC93@vnet.ibm.com> <3965DC16.7CB143B3@amulet.co.jp>
In-Reply-To: <3965DC16.7CB143B3@amulet.co.jp>
MIME-Version: 1.0
Message-Id: <00070709294600.00629@coruscant.terraplex.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think it's a great idea. I don't use MacOS so I don't share the concern of
how MacOS X could affect the partitions. Equally, I trust if Apple is properly
advised of such a change they would take measures to ensure compatibility.
Linux sells Apple hardware too. ;-)

Best Regards,
Charles Stevenson

On Fri, 07 Jul 2000, Hollis Blanchard wrote:
> Tom Gall wrote:
> >
> > Benjamin Herrenschmidt wrote:
> > >
> > > So I suggest moving to Linux_ext2, Linux_swap, or maybe simply Linux and
> > > Linux_swap (since ext2 is not the only filesystem Linux may put on
> > > these). Using a different type for swap would help avoiding confusion.
> >
> > I agree. I think this is a good step. However there's the obvious interoperability
> > problems with MacOS, OS X etc... Hopefully Apple's OSes wouldn't do anything evil
> > to the partition they don't recognize.
>
> Well, they don't at this point. For example in partitioning tool in
> LinuxPPC 2000, LinuxPPC Inc decided it would be better to use the type
> "Linux_PPC". This works (in that nothing gets overwritten, corrupted,
> etc) but has the disadvantage that no other software knows anything
> about that type.
>
> If you were writing software it would be pretty poor form to find data
> you didn't understand and decide to "fix" it. I know there are programs
> like that out there (if you look at
> http://www.win.tue.nl/~aeb/partitions/partition_types-1.html it seems
> there is a rich history of them), but Apple seems to be doing well in
> that regard so far...
>
> Of course, everything may change with OS X but I would hope they don't
> get malicious all of a sudden.
>
> -Hollis
--
  Terra Soft Solutions, Inc.
  http://www.terrasoftsolutions.com/

  Yellow Dog Linux
  "The Ultimate Companion for a Dedicated Server"
  http://www.yellowdoglinux.com/

  Black Lab Linux
  Advanced Workstations, Parallel, and Embedded Solutions
  http://www.blacklablinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
