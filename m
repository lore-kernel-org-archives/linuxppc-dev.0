From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <nicoya@apia.dhs.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linux-pmac-stable SMP issues
Date: Tue, 17 Oct 2000 12:38:28 +0200
Message-Id: <19340911041012.13299@192.168.1.2>
In-Reply-To: <200010170601.IAA06906@piglet.grunz.lu>
References: <200010170601.IAA06906@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It might not work as you want for dual booting, but you might want to
>try OF booting with quik. It's rather manual, but it may bring up your
>second processor...

Yup, try miBoot or quik. The problem here is that new versions of MacOS
have a small SMP nanokernel that is taking over the second CPU before
BootX can react.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
