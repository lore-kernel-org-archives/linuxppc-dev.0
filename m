Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: 8260 and skb implementation
Date: Tue, 7 May 2002 07:34:07 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFKEJPDGAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We have an 8260 based product and have many production boards with pre-B.3
rev processors. As mentioned on this list, we had to modify all CP related
communications to operate from local RAM to avoid lock-up problems.
Unfortunately this also means that all communication bufferss, especially
Ethernet, must be copied between the two memory spaces. Has anyone
considered moving the SKB memory into local RAM as well? On our hardware, we
have 8MB of local RAM. Is this a reasonable amount of memory for SKB or is
typical usage much higher?

TIA for the sanity check.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
