To: Larry McVoy <lm@bitmover.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Vger CVS R.I.P. (Was Re: the state of the linuxppc-dev community)
References: <200002092154.NAA13033@work.bitmover.com>
From: Jesper Skov <jskov@redhat.com>
Date: 10 Feb 2000 10:42:22 +0100
In-Reply-To: Larry McVoy's message of "Wed, 09 Feb 2000 13:54:15 -0800"
Message-ID: <otvh3xcs1t.fsf@thinktwice.zoftcorp.dk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Larry" == Larry McVoy <lm@bitmover.com> writes:
Larry> Basic stuff you'll need:

Larry>     # get yourself a baseline tree $ bk clone
Larry> hq.fsmlabs.com:/home/bk/linuxppc_2_3 linuxppc_2_3

Larry>     # Set it up for building/working (this checks out and locks
Larry> all files) $ bk -r edit

Larry>     # hack, build, debug, hack, build, debug

Larry>     # Run citool to commit (LOCALLY! Not like CVS) your changes
Larry> $ bk citool

Larry>     # Update your tree with anything that's happened since last
Larry> time $ bk pull

 bk resolve

 bk -r get

Larry>     # Push back any changes you've made $ bk push

Larry>     # Browse the tree's changes $ bk sccstool

Larry>     # Browse a specific file $ bk sccstool fs/ext2/super.c

Larry> There's tons more but that's all most people ever need.  Cort,
Larry> did I forget anything?


I'm not Cort, but I've been there :)  As I put in above, most people
(that do any hacking) would have to resolve conflicts between their
local tree and changes committed to Cort's tree.

And I find I also have to run 'bk -r get' after a pull to ensure all
new files get "checked out".



As for general usability, with a trained CVS monkey's POV, bk does
take some getting used to. My biggest problem has been finding the
proper documentation(*) - Larry, you may want to post the list above as a
CVS-user's-crash-course on the web site.

Another observation: keeping the repository data in the "build tree"
has caused me to do two things:

 Update my grep scripts and such to ignore SCCS directories.

 Use a buffer tree between Cort's tree and my development tree,
 allowing me to pull new changes without risking conflicts, and
 allowing simple tar-ball backups of the repository (without having to
 filter out checked out source files and random .o files).


Jesper


(*): plenty of documentation in the tools, it's just that I find
     myself clicking around in 'bk helptool' for a long time before I
     find what I need. I would have liked HTML/ASCII documentation
     better.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
