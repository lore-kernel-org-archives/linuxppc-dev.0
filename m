Date: Thu, 15 Mar 2001 19:27:06 +0100 (MET)
Message-Id: <200103151827.TAA26091@aste15.ida.liu.se>
From: "=?iso-8859-1?q?Bj=F6rn?= Wingman" <bjowi@ida.liu.se>
To: mgreer@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mcpn765
References: <yx2r8zzghpd.fsf@aste15.ida.liu.se> <3AB0EA13.B893E257@mvista.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Sounds like you're netbooting.

Yes.

> Using the niot cmd, make sure everything is set up correctly.
> Using the 'env' cmd, make sure network PREP-boot (or something like that)
> is turned on.

Yes, I think I have those correctly set up.

> I take it you're using the code in the linuxppc_2_5 right?

No. I pulled the sources with

bk clone bk://bitkeeper.fsmlabs.com:5005 linux_2_5

as some earlier mail said, but it seems to be incomplete. Several
directories, like kernel and mm are empty. Am I supposed to merge this
tree with the latest 2.4-tree somehow? Is there an FAQ somewhere that I
haven't found?

	/Björn Wingman

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
