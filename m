Date: Sun, 29 Oct 2000 10:25:31 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Michael Norton <mnorton@cisco.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: BIG ENDIAN or LITTLE ENDIAN
In-Reply-To: <200010282019.NAA19248@cisco.com>
Message-ID: <Pine.LNX.3.96.1001029102424.31042A-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 28 Oct 2000, Michael Norton wrote:

> I am working on some code that is particuliar of byte ordering. Is the
> G4, running PPC 2000 a BIG_ENDIAN machine?

All PowerPC machines running Linux are big-endian, by nature.  There's a
little-endian hack... err... mode in the processor, but I'm not aware of
any OS that uses it except possibly the ill-fated Windows NT port that was
never released....  :-/


David

---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
