Mime-Version: 1.0
Message-Id: <p04330101b69ea5b8618f@[24.163.36.97]>
In-Reply-To: <19341226073701.30276@mailhost.mipsys.com>
References: <p04330102b69d64c82c08@[24.163.36.97]>
 <19341226073701.30276@mailhost.mipsys.com>
Date: Thu, 1 Feb 2001 00:41:46 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: continuing XF402 (atimisc) problems
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >I've been over this on the -user list and the YDL list, and cc-ed Ani
>>a few times with it (no response). No one seems to have a clue as to
>>the cause of the problem, which is described concisely at:
>>
>><http://lists.linuxppc.org/listarcs/linuxppc-user/200101/msg00672.html>
>>
>>(more detail available if necessary)
>>
>>This is on a 6500 (on-board RageII) with a RagePro PCI card. I have
>>tried rolling my own XF402 build, with Ani's driver updates, and get
>>the exact same XFree log result. I've also tried several of kfukui's
>>402 rpms, including use of his "old drivers," again with exactly the
>>same result.
>
>Check that you have the correct fbdevhw module and that it's loaded in
>your XF86Config file.


I tried adding

	Load	"fbdevhw"

in the Modules section of XF86Config-4. There appeared to be no error
from this in the XF log, but I still got the same atimisc failure
(both 2.2.18 and 2.4.1). I'm not sure how I would check if fbdevhw is
the right version. I assume it is, simply because my attempts to
build XF402 seem to behave consistently, and I doubt kfukui has
constructed his several versions of rpm incorrectly. Granted, these
may be not good reasons to trust I have the right version :-)


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
