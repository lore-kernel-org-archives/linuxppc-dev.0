Message-ID: <F14441D40E5AD3118886005004607AD10BDD90@MAIL1>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'flar@allandria.com '" <flar@allandria.com>,
        "'viro@math.psu.edu '"
	 <viro@math.psu.edu>
Cc: "'dgatwood@deepspace.mklinux.org '" <dgatwood@deepspace.mklinux.org>,
        "'ak@suse.de '" <ak@suse.de>, "'lord@sgi.com '" <lord@sgi.com>,
        "'matthew@wil.cx '" <matthew@wil.cx>,
        "Halfmann, Klaus"
	 <khalfmann@libra.de>,
        "'roman@augan.com '" <roman@augan.com>,
        "'linuxppc-dev@lists.linuxppc.org '" <linuxppc-dev@lists.linuxppc.org>,
        "'linux-fsdevel@vger.kernel.org '" <linux-fsdevel@vger.kernel.org>
Subject: RE: Btree directories (Re: Status of HFS+ support)
Date: Fri, 1 Sep 2000 19:05:50 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


...
> OK. Are they [the CNISs] preserved by rename()?

> There isn't anything preventing it. A rename() is messy enough
> because of the headache of moving around entries in the btree
> and updating all the implicit usage of the catalog key which
> depends on the filename. I don't think the
> MacOS actually preserves the CNID on a rename, tho. It's something that
> I think would be about the same complexity either way. The only thing you
> save by keeping the same CNID is changes to the extents overflow tree,
> which is usually empty anyway. (My code doesn't do rename() yet...)

Brad, Im sure you are wrong on this one, try the following in MacOS:
create an alias to a folder and then renam it, the alias will stiil work
So Im sure the CNIDs will not change ..

Klaus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
