Message-ID: <393DF504.B7F839F8@jvc.nl>
Date: Wed, 07 Jun 2000 09:08:55 +0200
From: Stephan Leemburg <sleemburg@jvc.nl>
Reply-To: sleemburg@jvc.nl
MIME-Version: 1.0
To: daenzerm@student.ethz.ch
CC: Joseph Garcia <jpgarcia@execpc.com>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Francois Felix Ingrand <felix@ingrand.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo battery support (was 'Re: Debian pmud package available')
References: <Pine.LNX.4.10.10006062043470.29453-100000@zirkon.biophys.uni-duesseldorf.de>
		 <393D4D15.7CF12E4E@execpc.com> <393D5429.32BEFB20@relog.ch> <393D584C.6E4A32D8@execpc.com> <393D5B56.C54D9BCB@relog.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi to all,

FYI, in 2.2.16pre4, there is NO support for letting the Pismo and the
iBook sleep. It is however, as proven by the discussed battery monitors,
possible to get some info on the battery status. Supporting the KEYLARGO
is no trivial task, first of all, you need to have a iBook or Pismo to
experiment with and then get your hands dirty on trial and error kernel
modifications.
As I don't own a iBook or a Pismo, I cannot experiment with it and
experimenting over the net - that is one person writing the testcode and
the other testing it on a KEYLARGO based machine - is far to
inconvenient and will most probably not work.

For what that experimenting is concerned, I believe that in the latest
Darwin kernel there is some powermanagement code, which could be analysed.

Note that even though you cannot put the machines to sleep, you can have
pmud signal init that there is a powerfailure and have it shutdown...

--
Stephan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
