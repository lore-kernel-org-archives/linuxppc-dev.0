Message-ID: <20020920201320.14193.qmail@kunk.jriver.com>
Subject: Re: Missing iBook HD driver?
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 20 Sep 2002 15:13:20 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After corresponding with Ben H. on this and doing some testing
I reached the conclusion that:

If you have a dvd/cd-rw combo drive on a 600 mhz ibook the
stock 2.4 kernels will not recognise it. Ben has fixed this in
his kernel and I found an old reference in the faq-o-matic
(to an iMac) that you can work around it by specifying

hda=16383,16,63

as a kernel arg when booting from the install cd. I thought
I'd drop the info here so others can search it out when they
run into the same problem...

Bob

----- Forwarded message from Robert E Brose II -----
Subject: (fwd) Missing iBook HD driver?
Am I missing something? I'm trying to install on a 6 mo. old
iBook, 600 mhz, combo drive and 20 gig hd.

Neither debian 3.0, ydl 2.3 or gentoo 1.2 boot cd's find the
hard disk (though they all find the cd).

What's up with this??

-- end of forwarded message --

--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
