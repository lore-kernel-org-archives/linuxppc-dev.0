From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Robert E Brose II" <bob@kunk.jriver.com>,
	"Tony Howard" <tahoward@ntrnet.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: cdrecord, cdrdao failing with scsi bus reset
Date: Sat, 21 Sep 2002 13:55:13 +0200
Message-Id: <20020921115514.20288@192.168.4.1>
In-Reply-To: <20020921052807.20546.qmail@kunk.jriver.com>
References: <20020921052807.20546.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I got it off of this list myself, I think it was originally for
>2.4.3. I've just kept remaking it as I put new kernels on
>my machine as it seems to never have made it to the official
>kernel. It patches several scsi drivers but the only ones that
>affect Mac users are  the 53c94 and mesh drivers.
>
>http://www.jriver.com/~bob/daofix-2.4.17.diff
>
>Is against the 2.4.17 kernel. I just tried it on the latest
>benh 2.4 kernel (2.4.20-pre7) and it patched ALTHOUGH there
>were offsets in the mesh driver which seems to have been worked
>on lately. I haven't verified that it works past the 2.4.19
>kernel I'm currently using. YMMV.

Interesting. I don't think this patch does things the right
way though, but I'll see what I can do with it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
