Message-ID: <3E5E354D.605@stinkfoot.org>
Date: Thu, 27 Feb 2003 10:57:01 -0500
From: Ethan Weinstein <lists@stinkfoot.org>
MIME-Version: 1.0
To: Rudy Klinksiek <klink@arlut.utexas.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: "Illegal instruction" traps on smp clients - 2.4.19
References: <Pine.SOL.4.05.10302270842190.3567-100000@mamba.arlut.utexas.edu>
In-Reply-To: <Pine.SOL.4.05.10302270842190.3567-100000@mamba.arlut.utexas.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Rudy Klinksiek wrote:

| 	Smp and UP kernels work fine on the "server".
|
| 	Has anyone else seen this type of problem or something similar?
|

I have. I run a dual G4(7400), also with CONFIG_HIMEM and got plenty of
random SIGILL's, SIGABRT's and deamons crashing upon startup until I
started using Ben's bk tree.  I've been using 2.4.20-ben(x) for quite
some time now without this problem.

|         This appears to me to be an smp problem.

| 	And then, what can I do about it?  I'm willing to try things
| 	as my time permits.  I have looked at 2.5.60 memory.c/mmap.c
| 	and related functions, and trying to port the new methods
| 	back to 2.4.19 seems to be a rather daunting task.
|
|         Comments, suggestions?
|
Try rsyncing ben's bk tree and using it, it cleared up this issue for me.

rsync -avz --delete rsync.penguinppc.org::linux-2.4-benh


- -Ethan Weinstein


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
