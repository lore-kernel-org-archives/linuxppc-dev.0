Message-ID: <3C0D53EC.BF117A02@folkwang-hochschule.de>
Date: Tue, 04 Dec 2001 23:53:32 +0100
From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Derrik Pates <dpates@dsdk12.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.17-pre[12]-ben0 trees hang on unsuspend
References: <Pine.LNX.4.40.0112020854520.27544-100000@andromeda.dsdk12.net> <20331103021714.8497@smtp.wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >On Sun, 2 Dec 2001, Benjamin Herrenschmidt wrote:
> >
> >> Could be one of my sleep.S changes, let me check...
> >
> >I diff'd 2.4.16-ben0's sleep.S and 2.4.17-pre2-ben0's sleep.S, then
> >commented out the added stuff for register save/restore on 74x0 PPCs. That
> >seems to have corrected the problem - the system now wakes up correctly
> >from sleep, exactly as before. Any idea what's happening there? It looks
> >like that stuff shouldn't even be getting called for non-74x0 PPC
> >processors (/proc/cpuinfo IDs this system's CPU as a 750CX), so one of the
> >processor-type checks apparently isn't working quite right.
>
> Some bug in the assembly. I fixed it.

any guesses why i'm seeing the bug in 2.4.16-ben0 ?


--
Jörn Nettingsmeier
home://Kurfürstenstr.49.45138.Essen.Germany
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
