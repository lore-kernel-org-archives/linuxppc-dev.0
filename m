Date: Fri, 26 May 2000 23:36:39 +0200
Subject: CMD646
From: "Florent" <flobo@iname.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20000526214631.35D0F86C6D@postfix3.free.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

What has changed with the IDE CMD646 chipset driver ?
It used to work on my B&W G3 with kernel 2.2.14, but
it fails with 2.3.99, at least with my .config
file...
With 2.3.99pre9, it prints error messages "hda:
interrupt lost", but it detects all of my partitions
- including the root one . So it seems to be close to
work excepted it is extremely slow.

I can still boot and use my computer when I put my hard
drive on the second IDE bus which is not a CMD646, but I
don't think it is the good solution...

What is up with CMD64x on powermacs ? Has someone a
working .config file ? Or do I need to apply some
patches ?
Is there a known unsolved problem here ?

Thanks.

Florent

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
