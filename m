Date: Tue, 28 May 2002 16:56:39 -0500
From: Stephen Cameron <steve.cameron@hp.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Bitkeeper trouble
Message-ID: <20020528165639.A28325@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"bk pull" used to work, (1 week ago) but
now fails for me.

[scameron@zuul lxppc24d]$ bk pull
drainErrorMsg: Unexpected response:
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">

Anybody else seeing that?

[scameron@zuul lxppc24d]$ bk version
BitKeeper/Free version is bk-2.1.6-pre5 20020330075529 for x86-glibc21-linux
Built by: lm@redhat62.bitmover.com in /usr/build/bk-2.1.x-lm/src
Built on: Sat Mar 30 00:29:33 PST 2002
[scameron@zuul lxppc24d]$ cat BitKeeper/*/parent
http://ppc.bkserver.net/linuxppc_2_4_devel

Do I need a newer version of bitkeeper?
I didn't see one around.

I am going through an http proxy server
http_proxy=http://proxy.compaq.com:8080/

(Hmm, I wonder if they changed something about
it due to HP-Compaq merger?)

thanks for any hints.

-- steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
