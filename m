Date: Sun, 11 Jun 2000 20:12:35 -0700
From: Jag <agrajag@linuxpower.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: What is asmlinkage ?
Message-ID: <20000611201234.J8893@kotako.icecast.org>
References: <3943EA46.F7B10185@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3943EA46.F7B10185@videotron.ca>; from abz@videotron.ca on Sun, Jun 11, 2000 at 03:36:37PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 11 Jun 2000, Alain Birtz wrote:

>
> In /linux/shm.h there are many "asmlinkage" declaration like
>
> asmlinkage int sys_shmat();

asmlinkage is #define'd in /usr/include/linux/linkage.h

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
