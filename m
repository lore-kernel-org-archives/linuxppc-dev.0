From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: GeForce on PPC == _no work_
Date: Sun, 28 Oct 2001 15:54:35 +0100
Message-Id: <20011028145435.7084@smtp.wanadoo.fr>
In-Reply-To: <20011028125007.MHAN10438.tomts12-srv.bellnexxia.net@there>
References: <20011028125007.MHAN10438.tomts12-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Has anyone looked in the latest Darwin release?  Is there code there that
>supports flat panels on both Radeon and Nvidia?  If so, where would one
>look for it?

The video drivers are among the things Apple didn't open source as part
of Darwin :(

This includes all drivers not entirely owned by Apple (ATI, nVidia, Adaptec,
Airport, ...) and some Apple drivers they didnt want to open source for
various (bad) reasons (PMU, ieee1394 controllers).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
