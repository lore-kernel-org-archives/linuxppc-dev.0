Date: Wed, 19 Dec 2001 20:07:13 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: 7450 erratta fixed?
Message-ID: <Pine.LNX.4.33.0112191951110.9296-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Hi BenH et al,

 Just to report back, that I've been hammering away at my dual 800 running
2.4.17-rc2. And, so far it is taking a beating and still kicking. At the
moment my machine is rebuilding XFree86-4, Mesa, tetex, emacs, another 2.4
kernel while vi is doing a regex search/replace on a 300MB apache log
file and ftping a 1.9 GB gzipped file back and forth to another machine
next to it.

  8:02pm  up  1:08,  7 users,  load average: 10.34, 9.53, 7.80
82 processes: 68 sleeping, 12 running, 2 zombie, 0 stopped
CPU0 states: 66.1% user, 33.4% system,  0.0% nice,  0.0% idle
CPU1 states: 75.1% user, 24.3% system,  0.0% nice,  0.0% idle
Mem:  1026464K av, 1020568K used,    5896K free,   0K shrd,   34728K buff
Swap:  262136K av,     484K used,  261652K free              793024K cached


 So far, this is *much* better than what I had in the past. Whom ever did
these fixes I owe you a big thanks. You guys are amazing!

 I'll let you know if/when this machine crashes.

 Thanks again.

Cheers,

Chris


--

Christopher Murtagh
Webmaster / Sysadmin
Web Communications Group
McGill University
Montreal, Quebec
Canada

Tel.: (514) 398-3122
Fax:  (514) 398-2017


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
