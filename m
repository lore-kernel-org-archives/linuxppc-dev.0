Date: Wed, 6 Mar 2002 22:01:31 -0800 (PST)
From: Paul White <pwhite@bivio.net>
To: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPC7455
In-Reply-To: <20020306222402.NQN7616.tomts7-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.21.0203062200090.30207-100000@stimpy.networkrobots.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 6 Mar 2002, Kevin B. Hendricks wrote:

> Hmm, that's funny. My Dual 1 Gig G4 machine (7455) runs quite well (so
> far) with using the 7450 setup for the HID registers after adding the
> entries for detecting the 7455.  The bits that changed in HID0 are not
> played with in the 7450 setup so it should be okay (it seems to be
> working) shouldn't it?

Well it seems as though the G4 machines are setting up the CPU registers
in firmware, thus linux doesn't have to do anything.  On our board, our
firmware doesn't do this so we wanted to set the registers up in Linux.

> Yes I would very much like to see it.

Sure...I'll have a cleaned up patch file ready tomorrow evening, I
can e-mail it to the group here.

Paul W.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
