Date: Thu, 22 Apr 1999 00:54:07 -0400 (EDT)
From: Tom Vier <nester@erols.com>
Reply-To: Tom Vier <thomassr@erols.com>
To: "David A. Gatwood" <marsmail@globegate.utm.edu>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        root <roboj@ibm.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel 2.2.6-ac1 problem
In-Reply-To: <Pine.LNX.3.96.990420144859.24907A-100000@globegate.utm.edu>
Message-ID: <Pine.LNX.4.10.9904220050550.19091-100000@localhost.erols.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 20 Apr 1999, David A. Gatwood wrote:

> The related code I noticed changing was related to quota support.  It
> doesn't appear to be in the ext2fs code changes, though, because I tried
> backdating all of those (other than simple formatting and notational
> changes0 to no avail.  I'm thinking it might be in the general filesystem
> code.

any chance it could be the quota code? i have it enabled, but i don't have
it setup (no quotas) and i get minor corruption when copying and deleting
lots of files. does it happen with quotas disabled?

--
Tom Vier - 0x82B007A8
thomass@erols.com
http://www.erols.com/thomassr/zero/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
