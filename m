From: Benjamin Herrenschmidt <bh40@calva.net>
To: Topi Kanerva <tkanerva@ees2.oulu.fi>,
        Giuliano Pochini
 <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: can't boot 2.4.0-t9
Date: Mon, 9 Oct 2000 13:28:01 +0200
Message-Id: <19340903045945.2380@192.168.1.2>
In-Reply-To: <Pine.GSO.4.21.0010091229310.24725-100000@stekt6>
References: <Pine.GSO.4.21.0010091229310.24725-100000@stekt6>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>is this the plain 2.4.0-test9 or linuxcare devel version?
>If I were you, I'd try to backport the test7 scsi code to make
>the hack work again.
>I don't know about the drivers/scsi stuff, because I have a pismo
>(and hence no scsi), but for sure none of the 2.4.0-testx kernels
>have worked for me in terms of X: if I start X (4.0.1c), the
>lcd screen goes black, or then just completely wild.
>
>Can anyone else with a pismo confirm this?

For the SCSI resources problem, I have to check is the main tree is up-
to-date with the latest PPC fixes. You may want to try with the PPC
bitkeeper tree.

For the X 4 vs. 2.4 issue, I've been biten by this for a long time (on a
Pismo too and on a G4) until I figured out that the X server dies when
looking up font path. I had a broken font path in my /etc/X11/XF86Config,
removing it fixed the problem. (It's the last one in the list, it used to
give an error with older X servers).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
