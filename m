Message-ID: <20020529222336.30215.qmail@web20102.mail.yahoo.com>
Date: Wed, 29 May 2002 15:23:36 -0700 (PDT)
From: Owen Green <owenjinggreen@yahoo.com>
Subject: Memory usage
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20020529135428.B3960@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I`m currently developing applications for a linuxppc
embedded system (mpc8xx) with linux-2.4.4 from denx
and I realised that even with a tiny application I
spent something like 140k on my RAM area, where at
least 100k of that is for ld-2.2.3.so, I guess.
The question is, am I right? Is there a way to share
the code section of ld-2.2.3.so along applications? Is
there a way to get this memory size down?

Thanks in advance,

Owen.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
