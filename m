To: "kerler" <kerler@newmail.net>
Cc: "Kaoru Fukui" <k_fukui@highway.ne.jp>, <gcc@gcc.gnu.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: how to use macro in assemble language embedded in C?
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp>
	<or66kazecj.fsf@guarana.lsd.ic.unicamp.br>
	<3A4613FB.384BAD24@ife.ee.ethz.ch>
	<orsnnd3d6f.fsf@guarana.lsd.ic.unicamp.br>
	<00d001c06edc$f3ec3d20$5ef1d092@chn.agilent.com>
	<20001226221757.Postino-028251@smtp01.highway.ne.jp>
	<023e01c06fb5$dfe05a80$5ef1d092@chn.agilent.com>
From: Alexandre Oliva <aoliva@redhat.com>
Date: 27 Dec 2000 13:50:42 -0200
In-Reply-To: "kerler"'s message of "Wed, 27 Dec 2000 11:33:41 +0800"
Message-ID: <orhf3poobx.fsf@guarana.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Dec 27, 2000, "kerler" <kerler@newmail.net> wrote:

> so if i want use only one command line to compile temp.c,
> such as "gcc -c -other-option temp.c", which other-option should I add to
> make
> gcc creat a temporal assemble file /tmp/xxxx.S (not /tmp/xxxx.s) ?

I don't think there's any option to GCC that would make it run the
assembly code it outputs through a preprocessor.

--
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                  aoliva@{cygnus.com, redhat.com}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist    *Please* write to mailing lists, not to me

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
