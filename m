To: Henry Worth <haworth@ncal.verio.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xine, ppc and illegal instructions
References: <3ABC295A.DBBF800@ncal.verio.com>
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 24 Mar 2001 11:57:35 +0100
In-Reply-To: <3ABC295A.DBBF800@ncal.verio.com>
Message-ID: <874rwj5t9c.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henry Worth <haworth@ncal.verio.com> writes:

> Shutdown esd (best) or use the -A esd option.

I'm afraid that doesn't help at all. It still produces the illegal instruction.
Hmm.. running it using strace, I can sometimes make it get past the plugin-
check and show the box. This nearly never happens with all the plugins
available, but gets easier if I remove some of them.

I'll wait for the new patches and see if that changes anything though.

/Stefan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
