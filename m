To: sailer@ife.ee.ethz.ch
Cc: Kaoru Fukui <k_fukui@highway.ne.jp>, linuxppc-dev@lists.linuxppc.org,
        gcc@gcc.gnu.org
Subject: Re: kerne-2.4.0-test13pre3 with gcc-2.97
References: <20001223145258.Postino-022361@smtp01.highway.ne.jp>
	<or66kazecj.fsf@guarana.lsd.ic.unicamp.br>
	<3A4613FB.384BAD24@ife.ee.ethz.ch>
From: Alexandre Oliva <aoliva@redhat.com>
Date: 24 Dec 2000 16:08:08 -0200
In-Reply-To: Thomas Sailer's message of "Sun, 24 Dec 2000 16:19:23 +0100"
Message-ID: <orsnnd3d6f.fsf@guarana.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Dec 24, 2000, Thomas Sailer <sailer@ife.ee.ethz.ch> wrote:

> Alexandre Oliva wrote:

>> This change (and apparently all other changes you've made) are
>> definitely wrong.  Zero-sized arrays as the last element of a
>> structure used to be an extension in GCC 2.95.2, that has been adopted
>> by C99 with a slightly different syntax, that GCC CVS supports: just
>> remove the `0' from between the braces.

> Which is not backward compatible, unfortunately.

Indeed.  I wish we had maintained the old syntax for
backward-compatibility, even if with a deprecation warning.

--
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                  aoliva@{cygnus.com, redhat.com}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist    *Please* write to mailing lists, not to me

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
