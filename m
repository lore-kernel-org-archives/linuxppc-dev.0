Message-ID: <39AEAF7F.B36AFC53@relog.ch>
Date: Thu, 31 Aug 2000 21:18:23 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Joseph Garcia <jpgarcia@execpc.com>
CC: Gabriel Paubert <paubert@iram.es>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: 2.4 problems
References: <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es>
	 <39AE85BD.1B4651BB@relog.ch> <39AEAC18.7EA022BC@execpc.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph Garcia wrote:

> > A few days ago, I rsynced linux-pmac-devel and tried 2.4.0-test7(-pre?) .
> > I had problems with the network, no TCP connection could be established.
> > Anyone seen this?
>
> When I tried 2.4, it takes forever for a name to resolve.  connections seem
> ok once they are made.

For me, the names got resolved, but no HTTP, IMAP, ... connection could be
established. As ICQ also worked, I conclude that TCP didn't work but UDP did.


> My system also seems to have a fork problem in 2.4.  su hangs for 2-3
> minutes.

Haven't seen that.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and the DRI project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
